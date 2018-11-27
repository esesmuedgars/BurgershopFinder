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

    @IBOutlet private weak var collectionView: UICollectionView!

    private lazy var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        addHandlers()
    }

    private func addHandlers() {
        viewModel.items.bind(to: collectionView.rx.items(cellType: VenueCell.self)) { (_, identifier, cell) in
            let viewModel = VenueCellModel(forVenueWith: identifier)
            cell.configure(viewModel: viewModel)
        }.disposed(by: viewModel.disposeBag)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.authorize(self)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Did select item at row: \(indexPath.row).")
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - 30) / 2

        return CGSize(width: size, height: size)
    }
}
