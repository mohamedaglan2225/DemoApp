//
//  AppTabBarController.swift
//
//  Created by Mohamed Aglan®
//

import UIKit

class AppTabBarController: UITabBarController {
    
    
    //MARK: - Properties -
    
    //MARK: - LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.initialView()
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }

        let timeInterval: TimeInterval = 0.4
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
        }
        propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()
    }
    
    //MARK: - Initial -
    static func create() -> AppTabBarController {
        let vc = AppTabBarController()
        return vc
    }
    
    //MARK: - Design -
    private func initialView(){
        self.setupDesign()
        self.addChilds()
//        self.addMiddleButton()
//        self.addMiddleImage()
    }
    private func addChilds() {
        self.viewControllers = [
            home(),
            notification(),
            addAds(),
            chat(),
            account()
        ]
    }
    private func setupDesign() {
        
        
        let tabBarAppearance = UITabBarItem.appearance()
        UITabBar.appearance().tintColor = Theme.colors.mainColor
        self.tabBar.backgroundColor = .clear
        let attribute = [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 12)]
        tabBarAppearance.setBadgeTextAttributes(attribute as [NSAttributedString.Key : Any], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(attribute as [NSAttributedString.Key : Any], for: .normal)
        
        
        if #available(iOS 15.0, *) {
            
            let tabFont =  UIFont.systemFont(ofSize: 12)
            
            let appearance = UITabBarAppearance()
            
            
            let selectedAttributes: [NSAttributedString.Key: Any]
            = [NSAttributedString.Key.font: tabFont]
            
            let normalAttributes: [NSAttributedString.Key: Any]
            = [NSAttributedString.Key.font: tabFont, NSAttributedString.Key.foregroundColor: UIColor.gray]
            
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
            
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes
            
            appearance.inlineLayoutAppearance.normal.titleTextAttributes = normalAttributes
            
            appearance.inlineLayoutAppearance.selected.titleTextAttributes = selectedAttributes
            appearance.compactInlineLayoutAppearance.normal.titleTextAttributes = normalAttributes
            appearance.compactInlineLayoutAppearance.selected.titleTextAttributes = selectedAttributes
            
            self.tabBar.standardAppearance = appearance
            self.tabBar.scrollEdgeAppearance = appearance
            
        }
        
        
        
        
    }
    
    //MARK: - Doctors VCs -
    func home() -> UINavigationController {
        let vc = BaseVC()
        vc.tabBarItem = UITabBarItem(title: "Home".localized, image: UIImage(named: "tab0"), tag: 0)
        return BaseNav(rootViewController: vc)
    }
    func notification() -> UINavigationController {
        let vc = BaseVC()
        vc.tabBarItem = UITabBarItem(title: "Notifications".localized, image: UIImage(named: "tab1"), tag: 0)
        return BaseNav(rootViewController: vc)
    }
    func addAds() -> UINavigationController {
        let vc = BaseVC()
        vc.tabBarItem = UITabBarItem(title: "MGA".localized, image: UIImage(named: ""), tag: 0)
        return BaseNav(rootViewController: vc)
    }
    func chat() -> UINavigationController {
        let vc = BaseVC()
        vc.tabBarItem = UITabBarItem(title: "Chats".localized, image: UIImage(named: "tab3"), tag: 0)
        return BaseNav(rootViewController: vc)
    }
    func account() -> UINavigationController {
        let vc = BaseVC()
        vc.tabBarItem = UITabBarItem(title: "My Account".localized, image: UIImage(named: "tab4"), tag: 0)
        return BaseNav(rootViewController: vc)
    }
    
    
    //MARK: - Middle Button -
    func addMiddleButton(){
        let actionButton = UIButton()
        let unSelectedImage = UIImage()
        let selectedImage = UIImage()
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.setImage(unSelectedImage, for: .normal)
        actionButton.setImage(selectedImage, for: .selected)

        self.tabBar.addSubview(actionButton)
        self.tabBar.bringSubviewToFront(actionButton)
        
        actionButton.centerXAnchor.constraint(equalTo: self.tabBar.centerXAnchor).isActive = true
        actionButton.centerYAnchor.constraint(equalTo: self.tabBar.centerYAnchor).isActive = true
        actionButton.heightAnchor.constraint(equalTo: self.tabBar.heightAnchor).isActive = true
        actionButton.widthAnchor.constraint(equalToConstant: self.tabBar.bounds.width / CGFloat(self.viewControllers?.count ?? 1)).isActive = true

        actionButton.isEnabled = true
        actionButton.addTarget(self, action: #selector(self.middleButtonAction), for: .touchUpInside)
    }
    func addMiddleImage(){
        let length: CGFloat = 64
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tab2")
        imageView.contentMode = .scaleAspectFill
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false

        self.tabBar.addSubview(imageView)
        self.tabBar.bringSubviewToFront(imageView)
        
        imageView.centerXAnchor.constraint(equalTo: self.tabBar.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.tabBar.topAnchor, constant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: length).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: length).isActive = true
        imageView.layer.cornerRadius = length / 2
        
        
    }
    @objc private func middleButtonAction() {
        guard UserDefaults.isLogin else {
            AppAlert.showLogoutAlert {
                let vc = UIViewController() // show login
                let nav = BaseNav(rootViewController: vc)
                self.present(nav, animated: true)
            }
            return
        }
        self.present(self.addAds(), animated: true, completion: nil)
    }
    
    
}
extension AppTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let _ = viewControllers else { return false }
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false
        }
        
        guard fromView != toView else {
            return false
        }
        
        UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        return true
    }
}
