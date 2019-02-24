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
    convenience init(_ string: String?) {
        let attributes: [NSAttributedString.Key: Any] = [.kern: -1,
                                                         .foregroundColor: UIColor.white]

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

extension Data {
    init(contentsOf path: String, isDirectory: Bool = false, options: Data.ReadingOptions) throws {
        let url = URL(fileURLWithPath: path, isDirectory: isDirectory)
        try self.init(contentsOf: url, options: options)
    }
}

extension MapView {
    func zoomTo(_ coordinate: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        setRegion(region, animated: true)
    }

    func selectAnnotation(by identifier: FSIdentifier, animated: Bool = true) {
        if let annotation = annotations.compactMap({ $0 as? PointAnnotation })
            .first(where: { $0.identifier == identifier }) {
            zoomTo(annotation.coordinate)
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
