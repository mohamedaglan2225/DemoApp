//
//  RegisterVC.swift
//
//  Created by Mohamed Aglan®.
//


import UIKit

class RegisterVC: BaseVC {
    
    //MARK: - IBOutlets -
    @IBOutlet weak private var nameTextField: UITextField!
    @IBOutlet weak private var phoneTextField: UITextField!
    @IBOutlet weak private var emailTextField: UITextField!
    @IBOutlet weak private var passwordTextField: UITextField!
    @IBOutlet weak private var confirmPasswordTextField: UITextField!
    
    //MARK: - Properties -
    
    
    //MARK: - Creation -
    static func create() -> RegisterVC {
        let vc = AppStoryboards.auth.instantiate(RegisterVC.self)
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
        self.setupShowPasswordButtons()
    }
    private func setupShowPasswordButtons() {
        let showPasswordButton = self.createShowPasswordButton(action: #selector(self.togglePasswordSecure(_:)))
        
        let showConfirmPasswordButton = self.createShowPasswordButton(action: #selector(self.toggleConfirmPasswordSecure(_:)))
        
        
        self.add(secureButton: showPasswordButton, for: passwordTextField)
        self.add(secureButton: showConfirmPasswordButton, for: confirmPasswordTextField)
        
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
    @objc private func togglePasswordSecure(_ sender: UIButton) {
        self.passwordTextField.isSecureTextEntry.toggle()
        sender.isSelected.toggle()
    }
    @objc private func toggleConfirmPasswordSecure(_ sender: UIButton) {
        self.confirmPasswordTextField.isSecureTextEntry.toggle()
        sender.isSelected.toggle()
    }
    
    @IBAction private func registerButtonPressed() {
        do {
            
            let name = try ValidationService.validate(name: self.nameTextField.text)
            let phone = try ValidationService.validate(phone: self.phoneTextField.text)
            let email = try ValidationService.validate(email: self.emailTextField.text)
            let password = try ValidationService.validate(password: self.passwordTextField.text)
            let _ = try ValidationService.validate(newPassword: password, confirmPassword: self.confirmPasswordTextField.text)
            
//            self.registerWith(name, phone, email, password)
            
            self.goToVerificationCode(with: phone)
            
        } catch {
            self.showErrorAlert(error: error.localizedDescription)
        }
    }
    @IBAction private func loginButtonPressed() {
        self.popToRoot()
    }
    
}


//MARK: - Networking -
extension RegisterVC {
    private func registerWith(_ name: String, _ phone: String, _ email: String, _ password: String) {
        self.showIndicator()
        
        AuthRouter.registerWith(name: name, phone: phone, email: email, password: password).send { [weak self] (response: APIGenericResponse<User>) in
            
            guard let self = self else {return}
            
            
        }
    }
}

//MARK: - Routes -
extension RegisterVC {
    func goToVerificationCode(with credential: String) {
        let vc = VerificationCodeVC.create(credential: credential, type: .activation)
        self.push(vc)
    }
}
