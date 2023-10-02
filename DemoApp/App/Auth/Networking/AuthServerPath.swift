//
//  AuthServerPath.swift
//
//  Created by Mohamed Aglan®.
//

import Foundation


enum AuthServerPath {
    case login
    case register
    case verify
    case forgetPassword
    case forgetPasswordCode
    case resetPassword
}

extension AuthServerPath: ServerPath {
    var value: String {
        switch self {
        case .login:
            return "login"
        case .register:
            return "register"
        case .verify:
            return "verification_code"
        case .forgetPassword:
            return "forget_password"
        case .forgetPasswordCode:
            return "forget_password_code"
        case .resetPassword:
            return "reset_password"
        }
    }
}
