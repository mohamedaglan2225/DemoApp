//
//  AuthRouter.swift
//
//  Created by Mohamed Aglan®.
//

import Alamofire

enum AuthRouter {
    case login(credential: String, password: String)
    case registerWith(name: String, phone: String, email: String, password: String)
    case verify(code: String, credential: String)
    case forgetPassword(credential: String)
    case forgetPasswordCode(_ code: String, credential: String)
    case resetPassword(code: String, credential: String, password: String)
}

extension AuthRouter: APIRouter {
    
    var method: HTTPMethod {
        switch self {
            
        case .login:
            return .post
            
        case .registerWith:
            return .post
            
        case .verify:
            return .post
            
        case .forgetPassword:
            return .post
            
        case .forgetPasswordCode:
            return .post
            
        case .resetPassword:
            return .post
            
        }
    }
    
    var path: ServerPath {
        switch self {
            
            
        case .login:
            return AuthServerPath.login
            
        case .registerWith:
            return AuthServerPath.register
            
        case .verify:
            return AuthServerPath.verify
            
        case .forgetPassword:
            return AuthServerPath.forgetPassword
            
        case .forgetPasswordCode:
            return AuthServerPath.forgetPasswordCode
            
        case .resetPassword:
            return AuthServerPath.resetPassword
        }
    }
    
    var parameters: APIParameters? {
        switch self {
            
            
        case .login(let credential, let password):
            return [
                AuthParameterKeys.phone.rawValue: credential,
                AuthParameterKeys.password.rawValue: password
            ]
            
            
        case .registerWith(let name, let phone, let email, let password):
            return [
                AuthParameterKeys.name.rawValue: name,
                AuthParameterKeys.phone.rawValue: phone,
                AuthParameterKeys.email.rawValue: email,
                AuthParameterKeys.password.rawValue: password
            ]
            
            
        case .verify(let code, let credential):
            return [
                AuthParameterKeys.code.rawValue: code,
                AuthParameterKeys.phone.rawValue: credential
            ]
            
            
        case .forgetPassword(let credential):
            return [
                AuthParameterKeys.phone.rawValue: credential
            ]
            
            
        case .forgetPasswordCode(let code, let credential):
            return [
                AuthParameterKeys.code.rawValue: code,
                AuthParameterKeys.phone.rawValue: credential
            ]
            
            
        case .resetPassword(let code, let credential, let password):
            return [
                AuthParameterKeys.code.rawValue: code,
                AuthParameterKeys.phone.rawValue: credential,
                AuthParameterKeys.newPassword.rawValue: password
            ]
            
        }
    }
    
}
