//
//  CollectionViewFlowLayout.swift
//  burgershop-finder
//
//  Created by e.vanags on 20/04/2019.
//  Copyright © 2019 esesmuedgars. All rights reserved.
//

import UIKit

// TODO:
// Test on physical device if orientations .faceUp and .faceDown
// trigger any unexpected behaviour with invalidateLayout() and collectionViewContentSize
final class CollectionViewFlowLayout: SetupCollectionViewFlowLayout {

    private var _numberOfColumns: CGFloat = 1
    public var numberOfColumns: CGFloat {
        get {
            return _numberOfColumns
        }
        set {
            _numberOfColumns = newValue > 0 ? newValue : 1
        }
    }

    private var numberOfItems: CGFloat {
        guard let numberOfItems = collectionView?.numberOfItems(inSection: 0) else {
            return 0
        }

        return CGFloat(numberOfItems)
    }

    private var size: CGSize {
        return UIScreen.main.bounds.size
    }

    private var orientation: UIDeviceOrientation {
        return UIDevice.current.orientation
    }

    override var collectionViewContentSize: CGSize {
        let itemCount = numberOfItems / numberOfColumns
        let lineSpacingCount = itemCount - 1
        let verticalInsets = sectionInset.top + sectionInset.bottom

        if UIDevice.current.orientation.isPortrait {
            let width = min(size.width, size.height)
            let height = itemCount * itemSize.height + lineSpacingCount * minimumLineSpacing + verticalInsets

            return CGSize(width: width, height: height)
        } else if UIDevice.current.orientation.isLandscape {
            let width = max(size.width, size.height)
            let height = itemCount * itemSize.height + lineSpacingCount * minimumLineSpacing + verticalInsets

            return CGSize(width: width, height: height)
        }

        return .zero
    }

    override func setup() {
        sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 40, right: 20)
    }

    func invalidateItemSize() {
        let horizontalInsets = sectionInset.left + sectionInset.right

        if UIDevice.current.orientation.isPortrait {
            let width = min(size.width, size.height)
            let constant = (width - minimumLineSpacing - horizontalInsets) / numberOfColumns

            itemSize = CGSize(width: constant, height: constant)
        } else if UIDevice.current.orientation.isLandscape {
            let width = max(size.width, size.height)
            let constant = (width - minimumLineSpacing - horizontalInsets) / numberOfColumns

            itemSize = CGSize(width: constant, height: constant)
        }

        invalidateLayout()
    }
}
