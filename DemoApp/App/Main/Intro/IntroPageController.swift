//
//  IntroPageController.swift
//
//  Created by Mohamed Aglan®
//

import UIKit

class IntroPageController: UIPageViewController {
    
    //MARK: - Properties -
    private let nextTitle = "Next".localized
    private let continueTitle = "Continue".localized
    private let titleColor: UIColor = Theme.colors.secondaryColor
    private let tintColor: UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).withAlphaComponent(0.3)
    private var isLast = false
    private var nextTopAnchor: NSLayoutConstraint?
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private var subVC: [UIViewController] = []
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        return button
    }()
    private lazy var langButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeLanguage), for: .touchUpInside)
        return button
    }()
    private var pageControl = UIPageControl(frame: .zero)

    //MARK: - Creation -
    static func create(subVCs: [UIViewController]) -> IntroPageController {
        let vc = AppStoryboards.main.instantiate(IntroPageController.self)
        vc.subVC = subVCs
        return vc
    }
    
    //MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPageController()
        self.setupPageControl()
    }
    
    //MARK: - Design Methods -
    private func setupPageControl() {
        
        //PageControl
        self.pageControl.numberOfPages = subVC.count
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.isUserInteractionEnabled = false
        self.pageControl.currentPageIndicatorTintColor = .white
        self.pageControl.pageIndicatorTintColor = tintColor
        
        let leading = NSLayoutConstraint(item: self.pageControl, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 10)
        let top = NSLayoutConstraint(item: self.pageControl, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 50)
        
        view.addSubview(self.pageControl)
        view.addConstraints([top, leading])
        
        leading.isActive = true
        top.isActive = true
        
        
        //Next Button
        self.nextButton.setTitle(nextTitle, for: .normal)
        self.nextButton.setTitleColor(Theme.colors.mainColor, for: .normal)
        self.nextButton.alpha = 1
        self.view.addSubview(self.nextButton)
        
        self.nextTopAnchor = self.nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50)
        self.nextTopAnchor?.isActive = true
        self.nextButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        
        
        //Lang Button
        self.langButton.setTitle(Language.isRTL() ? "English" : "عربي", for: .normal)
        self.langButton.setTitleColor(.white, for: .normal)
        self.langButton.alpha = 1
        self.view.addSubview(self.langButton)
        
        self.langButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        self.langButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        
    }
    
    //MARK: - objc Methods -
    @objc private func nextButtonPressed() {
        self.goToNextPage()
    }
    @objc private func changeLanguage() {
        if Language.isRTL() {
            Language.setAppLanguage(lang: Language.Languages.en)
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        } else {
            Language.setAppLanguage(lang: Language.Languages.ar)
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        let vc = SplashVC.create()
        AppHelper.changeWindowRoot(vc: vc)
    }
    
    //MARK: - logic Methods -
    private func changeButtonTitle(currentIndex: Int) {
        if currentIndex == subVC.count - 1 {
            self.nextButton.setTitle(continueTitle, for: .normal)
        } else {
            self.nextButton.setTitle(nextTitle, for: .normal)
        }
    }
    private func showHideButtons(currentIndex: Int) {
        if currentIndex == subVC.count - 1 {
            isLast = true
            
            self.nextTopAnchor?.isActive = false
            
            self.nextTopAnchor = self.nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 50)
            
            self.nextTopAnchor?.isActive = true
            
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
            
        } else if currentIndex == subVC.count - 2 && isLast {
            isLast = false
            
            self.nextTopAnchor?.isActive = false
            
            
            self.nextTopAnchor = self.nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50)
            
            
            self.nextTopAnchor?.isActive = true
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
}

extension IntroPageController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private func setupPageController() {
        self.delegate = self
        self.dataSource = self
        self.setViewControllers([self.subVC[0]], direction: .forward, animated: true, completion: nil)
    }
    
    func goToNextPage(animated: Bool = true) {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) else { return }
        let currentIndex = subVC.firstIndex(of: nextViewController) ?? 0
        self.pageControl.currentPage = currentIndex
        showHideButtons(currentIndex: currentIndex)
        setViewControllers([nextViewController], direction: Language.isRTL() ? .reverse : .forward, animated: animated, completion: nil)
        
    }
    private func goToPreviousPage(animated: Bool = true) {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let previousViewController = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) else { return }
        let currentIndex = subVC.firstIndex(of: previousViewController) ?? 0
        self.pageControl.currentPage = currentIndex
        showHideButtons(currentIndex: currentIndex)
        setViewControllers([previousViewController], direction: Language.isRTL() ? .forward : .reverse, animated: animated, completion: nil)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.subVC.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = subVC.firstIndex(of: viewController) ?? 0
        self.pageControl.currentPage = currentIndex
        showHideButtons(currentIndex: currentIndex)
        if currentIndex <= 0 {
            return nil
        }
        return subVC[currentIndex - 1]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = subVC.firstIndex(of: viewController) ?? 0
        self.pageControl.currentPage = currentIndex
        showHideButtons(currentIndex: currentIndex)
        if currentIndex >= subVC.count - 1 {
            return nil
        }
        return subVC[currentIndex + 1]
    }
    
}
