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
import CoreLocation
import RxGesture

final class HomeViewController: UIViewController {

    @IBOutlet private var titleLabel: TitleLabel!
    @IBOutlet private var mapView: MapView!
    @IBOutlet private var collectionView: CollectionView! {
        didSet {
            collectionView.collectionViewFlowLayout?.numberOfColumns = 2
        }
    }
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var userLocationView: UIView! {
        didSet {
            userLocationView.layer.cornerRadius = 5
        }
    }
    @IBOutlet private var userLocationButton: UIButton!

    private lazy var viewModel = HomeViewModel()
    private lazy var locationManager = CLLocationManager()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self

        titleLabel.setTitle("Venues")

        bindRx()
    }

    private func bindRx() {
        viewModel.details
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [mapView] details in
                guard let details = details else { return }

                let annotation = PointAnnotation(details)
                mapView?.addAnnotation(annotation)
            }).disposed(by: viewModel.disposeBag)

        viewModel.items
            .bind(to: collectionView.rx.items(cellType: VenueCell.self)) { [weak self] (row, identifier, cell) in
                guard let self = self else { return }

                let cellModel = self.viewModel.cellModel(forVenueWith: identifier)
                cell.configure(with: cellModel)

                cell.rx.tapGesture().subscribe(onNext: { _ in
                    self.scrollView.setContentOffset(.zero, animated: true)
                    self.mapView.selectAnnotation(by: identifier)
                }, onError: { error in
                    print(error)
                }).disposed(by: self.viewModel.disposeBag)
            }.disposed(by: viewModel.disposeBag)

        viewModel.userLocationUpdated
            .drive(onNext: { [mapView] coordinate in
                mapView?.selectedAnnotations.forEach { annotation in
                    mapView?.deselectAnnotation(annotation, animated: true)
                }

                mapView?.zoomTo(coordinate, delta: 0.0005)
            })
            .disposed(by: viewModel.disposeBag)

        userLocationButton.rx.tap
            .bind(to: viewModel.focusLocationTaps)
            .disposed(by: viewModel.disposeBag)

    }

    private func presentDetails(for annotation: PointAnnotation) {
        guard let viewController = storyboard?.instantiateViewController(ofType: VenueDetailsViewController.self) else {
            return
        }

        let viewModel = VenueDetailsViewModel(annotation: annotation)
        viewController.configure(with: viewModel)
        present(viewController, animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.authorize(self)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)


        let annotation = mapView.selectedAnnotations.first as? PointAnnotation

        collectionView.invalidateIntrinsicContentSize()
        collectionView.collectionViewFlowLayout?.invalidateItemSize()

        if let identifier = annotation?.identifier {
            mapView.selectAnnotation(by: identifier, animated: false)
        }
    }
}

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? PointAnnotation else { return nil }

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotation.identifier) as? AnnotationView

        if annotationView == nil {
            annotationView = AnnotationView(annotation: annotation)
            annotationView?.setImage(annotation.image)
            annotationView?.button.rx.tap
                .subscribe({ [unowned self] _ in
                    self.presentDetails(for: annotation)
            }).disposed(by: viewModel.disposeBag)
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        viewModel.userLocationUpdate.onNext(userLocation)
    }
}

extension HomeViewController: CLLocationManagerDelegate {}
