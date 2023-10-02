//
//  LoginVC.swift
//
//  Created by Mohamed Aglan®.
//


import UIKit

class LoginVC: BaseVC {
    
    //MARK: - IBOutlets -
    @IBOutlet private weak var credentialTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    //MARK: - Properties -
    
    
    
    
    //MARK: - Creation -
    static func create() -> LoginVC {
        let vc = AppStoryboards.auth.instantiate(LoginVC.self)
        return vc
    }
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureInitialDesign()
    }
    
    
    //MARK: - Design Methods -
    private func configureInitialDesign() {
        self.title = "".localized
        self.setupShowPasswordButton()
    }
    
    private func setupShowPasswordButton() {
        let showPasswordButton = self.createShowPasswordButton(action: #selector(self.toggleSecure(_:)))
        self.add(secureButton: showPasswordButton, for: passwordTextField)
    }
    private func createShowPasswordButton(action: Selector) -> UIButton {
        let showPasswordButton = UIButton()
        
        
        showPasswordButton.setImage(UIImage(systemName: SFSymbol.eyeFill.rawValue), for: .normal)
        showPasswordButton.setImage(UIImage(systemName: SFSymbol.eyeSlashFill.rawValue), for: .selected)
        showPasswordButton.addTarget(self, action: action, for: .touchUpInside)
        return showPasswordButton
    }
    private func add(secureButton: UIButton, for textField: UITextField) {
        if Language.isRTL() {
            textField.rightView = secureButton
            textField.rightViewMode = .always
        } else {
            textField.leftView = secureButton
            textField.leftViewMode = .always
        }
    }
    
    
    
    //MARK: - Logic Methods -
    
    
    //MARK: - Actions -
    @objc private func toggleSecure(_ sender: UIButton) {
        self.passwordTextField.isSecureTextEntry.toggle()
        sender.isSelected.toggle()
    }
    @IBAction private func forgetPassword() {
        self.goToForgetPassword()
    }
    @IBAction private func skipButtonPressed() {
        self.skip()
    }
    @IBAction private func registerButtonPressed() {
        self.goToSignUp()
    }
    @IBAction private func loginButtonPressed() {
        do {
            let credential = try ValidationService.validate(phone: self.credentialTextField.text)
//            let credential = try ValidationService.validate(email: self.credentialTextField.text)
            let password = try ValidationService.validate(password: self.passwordTextField.text)
            self.loginWith(credential, password)
        } catch {
            self.showErrorAlert(error: error.localizedDescription)
        }
    }
    
}


//MARK: - Networking -
extension LoginVC {
    private func loginWith(_ credential: String, _ password: String) {
        
        self.showIndicator()
        
        AuthRouter.login(credential: credential, password: password).send { [weak self] (response: APIGenericResponse<User>) in
            
            guard let self = self else {return}
            
            
            
        }
        
    }
}

//MARK: - Routes -
extension LoginVC {
    private func goToForgetPassword() {
        let vc = ForgetPasswordVC.create()
        self.push(vc)
    }
    
    private func goToHome() {
        
    }
    
    private func goToSignUp() {
        let vc = RegisterVC.create()
        self.push(vc)
    }
    
    private func goToVerification(for credential: String) {
        let vc = VerificationCodeVC.create(credential: credential, type: .activation)
        self.push(vc)
    }
    
    private func skip() {
        
    }
}
