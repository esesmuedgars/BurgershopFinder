//
//  HomeViewController.swift
//  burgershop-finder
//
//  Created by e.vanags on 08/10/2018.
//  Copyright © 2018 esesmuedgars. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MapKit

final class HomeViewController: UIViewController {

    @IBOutlet private weak var titleLabel: TitleLabel!
    @IBOutlet private weak var mapView: MapView!
    @IBOutlet private weak var collectionView: CollectionView!

    private lazy var viewModel = HomeViewModel()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.setTitle("Venues")

        bindRx()
        
        CacheManager.shared.cache.removeAllObjects() // #debug
    }

    private func bindRx() {
        viewModel.details
            .subscribe(onNext: { [weak mapView] details in
                guard let details = details else { return }

                let annotation = PointAnnotation(details)
                mapView?.addAnnotation(annotation)
            }).disposed(by: viewModel.disposeBag)

        viewModel.items
            .bind(to: collectionView.rx.items(cellType: VenueCell.self)) { [weak self] (row, identifier, cell) in
                guard let self = self else { return }

                let cellModel = self.viewModel.cellModel(forVenueWith: identifier)
                cell.configure(with: cellModel)

                cell.touchUpInside.subscribe(onNext: { _ in
                    self.mapView.selectAnnotation(by: identifier)
                }, onError: { error in
                    print(error)
                }).disposed(by: self.viewModel.disposeBag)
            }.disposed(by: viewModel.disposeBag)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.authorize(self)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - 50) / 2

        return CGSize(width: size, height: size)
    }
}

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? PointAnnotation else { return nil }

        let identifier = "VenueAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? AnnotationView

        if annotationView == nil {
            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.setImage(annotation.image)
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
}
