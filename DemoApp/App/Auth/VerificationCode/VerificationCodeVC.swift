//
//  VerificationCodeVC.swift
//
//  Created by Mohamed Aglan®.
//


import UIKit

class VerificationCodeVC: BaseVC {
    
    enum VerificationType {
        case activation
        case forgetPassword
    }
    
    
    //MARK: - IBOutlets -
    @IBOutlet weak private var codeTextField: UITextField!
    
    //MARK: - Properties -
    var credential: String!
    var type: VerificationType = .activation
    
    //MARK: - Creation -
    static func create(credential: String, type: VerificationType) -> VerificationCodeVC {
        let vc = AppStoryboards.auth.instantiate(VerificationCodeVC.self)
        vc.credential = credential
        vc.type = type
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
    }
    
    //MARK: - Logic Methods -
    
    
    //MARK: - Actions -
    @IBAction private func verifyButtonPressed() {
        do {
            
            let code = try ValidationService.validate(verificationCode: self.codeTextField.text)
            
            switch self.type {
            case .activation:
                self.verify(code, for: credential)
            case .forgetPassword:
//                self.forgetPassword(code, for: credential)
                self.goToResetPassword(code: code, for: credential)
            }
            
            
        } catch {
            self.showErrorAlert(error: error.localizedDescription)
        }
    }
    @IBAction private func resendButtonPressed() {
        
    }
    
}


//MARK: - Networking -
extension VerificationCodeVC {
    private func verify(_ code: String, for credential: String) {
        self.showIndicator()
        
        AuthRouter.verify(code: code, credential: credential).send { [weak self] (response: APIGenericResponse<User>) in
            
            guard let self = self else {return}
            
            
            
        }
        
    }
    private func forgetPassword(_ code: String, for credential: String) {
        self.showIndicator()
        
        AuthRouter.forgetPasswordCode(code, credential: credential).send { [weak self] (response: APIGenericResponse<User>) in
            
            guard let self = self else {return}
            
            
        }
    }
}

//MARK: - Routes -
extension VerificationCodeVC {
    func goToResetPassword(code: String, for credential: String) {
        let vc = ResetPasswordVC.create(credential: credential, code: code)
        self.push(vc)
    }
}
