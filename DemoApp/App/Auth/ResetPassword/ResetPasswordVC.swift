//
//  ResetPasswordVC.swift
//
//  Created by Mohamed Aglan®.
//


import UIKit

class ResetPasswordVC: BaseVC {
    
    //MARK: - IBOutlets -
    @IBOutlet weak private var newPasswordTextField: UITextField!
    @IBOutlet weak private var confirmNewPasswordTextField: UITextField!
    
    //MARK: - Properties -
    var credential: String!
    var code: String!
    
    //MARK: - Creation -
    static func create(credential: String, code: String) -> ResetPasswordVC {
        let vc = AppStoryboards.auth.instantiate(ResetPasswordVC.self)
        vc.credential = credential
        vc.code = code
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
        
        
        self.add(secureButton: showPasswordButton, for: newPasswordTextField)
        self.add(secureButton: showConfirmPasswordButton, for: confirmNewPasswordTextField)
        
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
        self.newPasswordTextField.isSecureTextEntry.toggle()
        sender.isSelected.toggle()
    }
    @objc private func toggleConfirmPasswordSecure(_ sender: UIButton) {
        self.confirmNewPasswordTextField.isSecureTextEntry.toggle()
        sender.isSelected.toggle()
    }
    
    @IBAction private func resetButtonPressed() {
        do {
            let newPassword = try ValidationService.validate(newPassword: self.newPasswordTextField.text)
            let _ = try ValidationService.validate(newPassword: newPassword, confirmNewPassword: self.confirmNewPasswordTextField.text)
            
//            self.resetPassword(code: self.code, credential: self.credential, password: newPassword)
            
            self.goToLogin()
            
        } catch {
            self.showErrorAlert(error: error.localizedDescription)
        }
    }
}


//MARK: - Networking -
extension ResetPasswordVC {
    private func resetPassword(code: String, credential: String, password: String) {
        self.showIndicator()
        
        AuthRouter.resetPassword(code: code, credential: credential, password: password).send { [weak self] (response: APIGenericResponse<User>) in
            
            guard let self = self else {return}
            
            
        }
    }
}

//MARK: - Routes -
extension ResetPasswordVC {
    private func goToLogin() {
        self.popToRoot()
    }
}
