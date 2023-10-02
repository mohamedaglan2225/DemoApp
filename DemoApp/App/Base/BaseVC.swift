//
//  BaseVC.swift
//
//  Created by Mohamed Aglan®
//

import UIKit

class BaseVC: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBaseVC()
        self.addKeyboardDismiss()
    }
    
    //MARK: - Design -
    private func setupBaseVC() {
//        self.view.backgroundColor = Theme.colors.mainBackgroundColor
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        self.view.tintColor = Theme.colors.mainColor
    }
    func setupNavigationView() {
        let logo = UIImage(named: "appLogo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    
    func addBackButtonWith(title: String) {
        let button = UIButton()
        if Language.isRTL() {
            button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        }else {
            button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        }
        button.tintColor = UIColor.black
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = UIColor.black
        button.isUserInteractionEnabled = false
        let stack = UIStackView.init(arrangedSubviews: [button, titleLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.backButtonPressed))
        stack.addGestureRecognizer(tap)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: stack)
    }
    
    func addAuthBackButtonWith(title: String) {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = UIColor.black
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = UIColor.black
        button.isUserInteractionEnabled = false
        let stack = UIStackView.init(arrangedSubviews: [button, titleLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.backButtonPressed))
        stack.addGestureRecognizer(tap)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: stack)
    }
    
    func setLeading(title: String?) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = UIColor.black
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }
    
    
    func changeNavigationBar(alpha: CGFloat) {
        self.navigationController?.navigationBar.subviews.first?.alpha = alpha
    }
    
    //MARK: - Deinit -
    deinit {
        print("\(NSStringFromClass(self.classForCoder).components(separatedBy: ".").last ?? "BaseVC") is deinit, No memory leak found")
    }
    
    
    //MARK: - Actions -
    @objc func backButtonPressed() {
        self.pop()
    }

    
}

//MARK: - Dismiss Keyboard -
extension BaseVC {
    private func addKeyboardDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
        
    }
}

//MARK: - Alerts and indicators -
extension BaseVC {
    
    func showIndicator(){
        AppIndicator.shared.show(isGif: true)
    }
    func hideIndicator(){
        AppIndicator.shared.dismiss()
    }
    
    func showErrorAlert(error: String?){
        AppAlert.showErrorAlert(error: error)
    }
    func showSuccessAlert(message: String?){
        AppAlert.showSuccessAlert(message: message)
    }
    func showSomethingError(){
        AppAlert.showSomethingError()
    }
    
    func showInternetConnectionErrorAlert(completion:@escaping(()->())){
        AppAlert.showInternetConnectionErrorAlert(completion: completion)
    }
    func showDeleteAlert(complation: @escaping () -> ()) {
        AppAlert.showDeleteAlert(complation: complation)
    }
    func showLoginAlert(complation: @escaping () -> ()) {
        AppAlert.showLoginAlert(complation: complation)
    }
    func showLogoutAlert(complation: @escaping () -> ()) {
        AppAlert.showLogoutAlert(complation: complation)
    }
    
    func presentLogin() {
        fatalError("Handel this method")
//        let vc = LoginVC.create()
//        let nav = BaseNav(rootViewController: vc)
//        self.present(nav, animated: true, completion: nil)
    }
    
}

//MARK: - Router -
extension BaseVC {
    func push(_ viewController: UIViewController, animated: Bool = true) {
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    func pop(animated: Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }
    func pop(animated: Bool = true, completion: @escaping () -> Void) {
        navigationController?.popViewController(animated: animated)
        
        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
    func popToRoot(animated: Bool = true) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
