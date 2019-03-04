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
import MapKit
import CoreLocation

extension String: Error {}

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}

extension Reactive where Base : UICollectionView {
    public func items<S, Cell, O>(cellType: Cell.Type) -> (O) -> (@escaping (Int, S.Iterator.Element, Cell) -> Void) -> Disposable where S : Sequence, S == O.E, Cell : UICollectionViewCell, O : ObservableType {
        return items(cellIdentifier: String(describing: cellType), cellType: cellType)
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
        return UIGraphicsImageRenderer(size: size).image { [weak self] _ in
            self?.draw(in: CGRect(origin: .zero, size: size))
        }
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
    convenience init?<T>(_ value: T?) {
        guard let value = value else { return nil }

        let attributes: [NSAttributedString.Key: Any] = [.kern: -1,
                                                         .foregroundColor: UIColor.white]

        self.init(string: "\(value)", attributes: attributes)
    }
}

extension NSMutableAttributedString {
    convenience init(_ string: String, range: NSRange) {
        let attributes: [NSAttributedString.Key: Any] = [.kern: 2,
                                                         .foregroundColor: UIColor.white]

        self.init(string: string, attributes: attributes)

        addAttributes([.foregroundColor: UIColor.white.withAlphaComponent(0.4)], range: range)
    }
}

extension UICollectionView {
    var isEmpty: Bool {
        get {
            return numberOfItems(inSection: 0) == 0
        }
    }
}

extension Data {
    init(contentsOf path: String, isDirectory: Bool = false, options: Data.ReadingOptions) throws {
        let url = URL(fileURLWithPath: path, isDirectory: isDirectory)
        try self.init(contentsOf: url, options: options)
    }
}

extension MapView {
    func zoomTo(_ coordinate: CLLocationCoordinate2D, delta: CLLocationDegrees) {
        let span = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        setRegion(region, animated: true)
    }

    func selectAnnotation(by identifier: FSIdentifier, animated: Bool = true) {
        if let annotation = annotations.compactMap({ $0 as? PointAnnotation })
            .first(where: { $0.identifier == identifier }) {
            zoomTo(annotation.coordinate, delta: 0.005)
            selectAnnotation(annotation, animated: animated)
        }
    }
}

extension UIStoryboard {
    func instantiateViewController<Controller: UIViewController>(ofType type: Controller.Type) -> Controller? {
        return instantiateViewController(withIdentifier: String(describing: type)) as? Controller
    }
}

extension CLLocationCoordinate2D {
    static var `default`: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: 59.436597148286616,
                                      longitude: 24.750014910068785)
    }
}

extension Array {
    var isNotEmpty: Bool {
        get {
            return !isEmpty
        }
    }
}

extension Optional where Wrapped == String {
    var isEmptyOrNil: Bool {
        get {
            guard let self = self else {
                return true
            }

            return self.isEmpty
        }
    }
}

extension String {
    func substring(start: Int, offsetBy offset: Int) -> Substring? {
        guard let startIndex = index(self.startIndex, offsetBy: start, limitedBy: self.endIndex) else {
            return nil
        }

        guard let endIndex = index(self.startIndex, offsetBy: start + offset, limitedBy: self.endIndex) else {
            return nil
        }

        return self[startIndex ..< endIndex]
    }
}
