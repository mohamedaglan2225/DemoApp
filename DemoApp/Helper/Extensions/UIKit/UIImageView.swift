//
//  UIImageView.swift
//
//  Created by Mohamed Aglan®
//

import Kingfisher


extension UIImageView {
    func setWith(url: String?) {
        self.kf.indicatorType = .activity
        if let newURL = ((url ?? "")).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            self.kf.setImage(with: URL(string: newURL), placeholder: image, options: [.transition(.fade(0.2))])
            return
        }
        self.kf.setImage(with: URL(string: (url ?? "")), placeholder: image, options: [.transition(.fade(0.2))])
    }
}

