//
//  Extensions+UICollectionView.swift
//
//  Created by Mohamed Aglan®
//

import UIKit

extension UICollectionViewFlowLayout {
    
    open override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return Language.isRTL() ? true : false
    }
    
}
