//
//  CollectionView.swift
//  burgershop-finder
//
//  Created by e.vanags on 06/12/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import UIKit

final class CollectionView: SetupCollectionView {
    override func reloadData() {
        super.reloadData()
        invalidateIntrinsicContentSize()
    }

    override var intrinsicContentSize: CGSize {
        guard isEmpty else {
            return self.collectionViewLayout.collectionViewContentSize
        }

        return UIScreen.main.bounds.size
    }
}
