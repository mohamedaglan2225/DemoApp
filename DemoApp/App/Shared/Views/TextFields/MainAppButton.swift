//
//  MainAppButton.swift
//
//  Created by Mohamed Aglan®.
//

import UIKit


class MainAppButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.backgroundColor = Theme.colors.mainColor
        self.setTitleColor(Theme.colors.whiteColor, for: .normal)
    }
}
