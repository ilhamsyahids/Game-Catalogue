//
//  FavoriteViewController.swift
//  Game Catalogue
//
//  Created by Ilhamsyahids on 04/10/20.
//  Copyright © 2020 Ilhamsyahids. All rights reserved.
//

import UIKit
import LBTATools

class FavoriteViewController: LBTAListController<GameFavoriteCell, GameRealmResult> {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getData()
    }

    private func setupUI() {
        self.title = "Favorites"
        self.collectionView.backgroundColor = .systemBackground
    }

    private func getData() {
        let listOfGames = GameRealmResult.get(isFavorite: true)
        if listOfGames.count != 0 {
            self.items.append(contentsOf: listOfGames.reversed())

            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } else {
            NotificationCenter.default.post(name: .notificationReloadFab, object: nil)
            self.navigationController?.popViewController(animated: false)
        }
    }

    func reloadItems() {
        self.items.removeAll()
        getData()
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension FavoriteViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 32
        return .init(width: width, height: 80)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 16, bottom: 16, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.gameID = items[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
