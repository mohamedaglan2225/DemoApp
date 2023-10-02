//
//  ForgetPasswordVC.swift
//
//  Created by Mohamed Aglan®.
//


import UIKit

class ForgetPasswordVC: BaseVC {
    
    //MARK: - IBOutlets -
    @IBOutlet private weak var credentialTextField: UITextField!
    
    //MARK: - Properties -
    
    
    //MARK: - Creation -
    static func create() -> ForgetPasswordVC {
        let vc = AppStoryboards.auth.instantiate(ForgetPasswordVC.self)
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
    @IBAction private func continueButtonPressed() {
        do {
            let credential = try ValidationService.validate(phone: self.credentialTextField.text)
//            let credential = try ValidationService.validate(email: self.credentialTextField.text)
            
//            self.forgetPassword(for: credential)
            
            self.goToVerificationCode(with: credential)
            
        } catch {
            self.showErrorAlert(error: error.localizedDescription)
        }
    }
}


//MARK: - Networking -
extension ForgetPasswordVC {
    private func forgetPassword(for credential: String) {
        self.showIndicator()
        
        AuthRouter.forgetPassword(credential: credential).send { [weak self] (response: APIGenericResponse<User>) in
            
            guard let self = self else {return}
            
            
            
        }
    }
}

//MARK: - Routes -
extension ForgetPasswordVC {
    func goToVerificationCode(with credential: String) {
        let vc = VerificationCodeVC.create(credential: credential, type: .forgetPassword)
        self.push(vc)
    }
}
