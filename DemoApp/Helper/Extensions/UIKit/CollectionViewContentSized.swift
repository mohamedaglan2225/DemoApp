//
//  CollectionViewContentSized.swift
//
//  Created by Mohamed Aglan®
//

import UIKit

class CollectionViewContentSized: UICollectionView {
    override var contentSize:CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
