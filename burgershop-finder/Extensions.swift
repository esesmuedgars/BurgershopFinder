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

/// Called from AppDelegate of application target.
/// Test targed gets its own registerDependencies() implementation,
/// with its own types (mocks) where needed.
extension DependencyAssembler {

    static func registerDependencies() {
        register(dependencies: MainDependencies())
    }
}

