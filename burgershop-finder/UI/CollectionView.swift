//
//  CollectionView.swift
//  burgershop-finder
//
//  Created by e.vanags on 06/12/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import UIKit

final class CollectionView: SetupCollectionView {

    var collectionViewFlowLayout: CollectionViewFlowLayout? {
        return collectionViewLayout as? CollectionViewFlowLayout
    }

    override func reloadData() {
        super.reloadData()

        invalidateIntrinsicContentSize()
        collectionViewFlowLayout?.invalidateItemSize()
    }

    override var intrinsicContentSize: CGSize {
        guard isEmpty else {
            return collectionViewLayout.collectionViewContentSize
        }

        return UIScreen.main.bounds.size
    }
}
