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

        titleLabel.text = "Venues"

        addHandlers()
        
        CacheManager.shared.cache.removeAllObjects() // #debug
    }

    private func addHandlers() {
        viewModel.details.observeOn(MainScheduler.instance)
            .subscribe { [weak mapView] event in
                // TODO: check how often this is called
                guard let item = event.element, let annotation = item?.location else { return }
                mapView?.addAnnotation(annotation)
        }.disposed(by: viewModel.disposeBag)

        viewModel.items.bind(to: collectionView.rx.items(cellType: VenueCell.self)) { [weak viewModel] (_, identifier, cell) in
            let cellModel = viewModel?.cellModel(forVenueWith: identifier)
            cell.configure(with: cellModel)
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
