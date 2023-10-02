//
//  AppStoryboards.swift
//
//  Created by Mohamed Aglan®
//

import UIKit

public enum AppStoryboards: String {

    case main = "Main"
    case auth = "Auth"
    case shared = "Shared"
    

}
extension AppStoryboards {
    public func instantiate<VC: UIViewController>(_ viewController: VC.Type) -> VC {

        guard let vc = UIStoryboard(name: self.rawValue, bundle: nil)  // bundl
                .instantiateViewController(withIdentifier: VC.storyboardIdentifier) as? VC
        else { fatalError("Couldn't instantiate \(VC.storyboardIdentifier) from \(self.rawValue)") }
        return vc
    }
    public func instantiateWith(identifier: String) -> UIViewController {
        let vc = UIStoryboard(name: self.rawValue, bundle: nil).instantiateViewController(withIdentifier: identifier)
        return vc
    }
    public func initialVC() -> UIViewController? {
        guard let vc = UIStoryboard(name: self.rawValue, bundle: nil).instantiateInitialViewController() else {return nil}
        return vc
    }
}
extension UIViewController {

    public static var storyboardIdentifier: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
}

