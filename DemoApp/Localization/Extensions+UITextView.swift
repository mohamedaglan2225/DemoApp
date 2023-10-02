//
//  Extensions+UITextView.swift
//
//  Created by Mohamed Aglan®
//

import UIKit

//MARK:- Localization
extension UITextView {
    open override func awakeFromNib() {
        super.awakeFromNib()
        if Language.isRTL() {
            if textAlignment == .natural {
                self.textAlignment = .right
            }
        } else {
            if textAlignment == .natural {
                self.textAlignment = .left
            }
        }
    }
}

