//
//  Extensions.swift
//  burgershop-finder
//
//  Created by e.vanags on 27/11/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

extension String: Error {}

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}

extension Reactive where Base : UICollectionView {
    public func items<S, Cell, O>(cellType: Cell.Type) -> (O) -> (@escaping (Int, S.Iterator.Element, Cell) -> Void) -> Disposable where S : Sequence, S == O.E, Cell : UICollectionViewCell, O : ObservableType {
        return items(cellIdentifier: String(describing: cellType), cellType: cellType)
    }
}

extension DependencyAssembler {
    static func registerDependencies() {
        register(dependencies: MainDependencies())
    }
}

extension NSCache where KeyType == NSString, ObjectType == UIImage {
    func get(forKey key: String) -> UIImage? {
        return object(forKey: NSString(string: key))
    }

    func set(_ image: UIImage?, forKey key: String) {
        if let image = image {
            setObject(image, forKey: NSString(string: key))
        }
    }
}

extension UIImage {
    convenience init?(_ photo: FSItem) {
        guard let data = try? Data(contentsOf: photo.url) else { return nil }
        self.init(data: data)
    }

    func withSize(_ size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

extension UIFont {
    private static var fontName: String {
        return "Arial-BoldMT"
    }

    static func withSize(_ size: CGFloat) -> UIFont? {
        return UIFont(name: fontName, size: size)
    }
}

extension NSAttributedString {
    convenience init(_ string: String?) {
        let attributes: [NSAttributedString.Key: Any] = [.kern: -1]

        self.init(string: string ?? String(), attributes: attributes)
    }
}

extension UICollectionView {
    var isEmpty: Bool {
        get {
            return numberOfItems(inSection: 0) == 0
        }
    }
}
