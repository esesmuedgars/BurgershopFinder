//
//  GradientView.swift
//  burgershop-finder
//
//  Created by e.vanags on 25/11/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

@IBDesignable
final class GradientView: SetupView {

    private lazy var disposeBag = DisposeBag()

    private let setTopColor = BehaviorSubject<UIColor>(value: .white)
    private let setBottomColor = BehaviorSubject<UIColor>(value: .white)
    private let setColorBlending = PublishSubject<Void>()

    override func setup() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        layer.frame = bounds

        bindRx()
    }

    private func bindRx() {
        let colors = Observable.zip(setTopColor.asObservable(), setBottomColor.asObservable())

        setColorBlending
            .startWith(())
            .withLatestFrom(colors)
            .subscribe(onNext: { [unowned self] top, bottom in
                guard let layer = self.layer as? CAGradientLayer else { return }

                if self.colorBlending {
                    layer.colors = [top.cgColor, bottom.cgColor]
                } else {
                    layer.colors = [top.cgColor, top.cgColor, bottom.cgColor, bottom.cgColor]
                    layer.locations = [0, 0.5, 0.5, 1]
                }
            })
            .disposed(by: disposeBag)
    }

    @IBInspectable
    public var topColor: UIColor = .white {
        didSet {
            setTopColor.onNext(topColor)
        }
    }

    @IBInspectable
    public var bottomColor: UIColor = .white {
        didSet {
            setBottomColor.onNext(bottomColor)
        }
    }

    @IBInspectable
    public var colorBlending: Bool = true {
        didSet {
            setColorBlending.onNext(())
        }
    }

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}
