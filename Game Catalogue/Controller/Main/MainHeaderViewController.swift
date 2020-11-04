//
//  MainHeaderViewController.swift
//  Game Catalogue
//
//  Created by Ilhamsyahids on 04/10/20.
//  Copyright © 2020 Ilhamsyahids. All rights reserved.
//

import UIKit
import LBTATools

var DEV_ID = 0
var DEV_PAGE = 1

class MainHeaderViewController: LBTAListController<GameHeaderCell, DeveloperListResult> {
    
    var LOADING_PAGE: Bool = false

    private lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "lineColor") ?? UIColor.systemGray
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getDevelopers(page: DEV_PAGE)
    }

    private func setupUI() {
        self.collectionView.backgroundColor = .systemBackground
        self.view.addSubview(lineView)
        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            lineView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            lineView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.5),
        ])
    }

    private func getDevelopers(page: Int) {
        API.shared.getDeveloperList(page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let games):
                self.updateUI(with: games)
            case .failure(let error):
                self.showLoadingIndicator(false)
                self.showAlertOnMainThread(message: error.rawValue)
            }
        }
    }

    private func updateUI(with data: DeveloperList) {

        if let results = data.results, !results.isEmpty, results.count > 0 {

            self.items.removeAll()
            
            if (LOADING_PAGE) {
                NotificationCenter.default.post(name: .notificationReloadItemGames, object: nil, userInfo: ["loading" : false])
            }

            if let _ = data.prev {
                items.append(DeveloperListResult("<"))
            }

            for (index, result) in results.enumerated() {
                if index == 0 {
                    DEV_ID = results[index].id ?? 0
                }
                items.append(result)
             }
            
            if let _ = data.next {
                items.append(DeveloperListResult(">"))
            }

            NotificationCenter.default.post(name: .notificationReloadItemGames, object: nil, userInfo: ["developerID" : DEV_ID])

            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        else {
            DispatchQueue.main.async {
                let message = "Sorry, data is empty :("
                self.showAlertOnMainThread(message: message)
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainHeaderViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = items[indexPath.row].name ?? ""
        let width = self.estimatedFrame(text: text, font: .systemFont(ofSize: 13)).width
        return CGSize(width: width + 50, height: 55)
    }

    func estimatedFrame(text: String, font: UIFont) -> CGRect {
        let size = CGSize(width: 200, height: 55)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size,
                                                   options: options,
                                                   attributes: [NSAttributedString.Key.font: font],
                                                   context: nil)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 16, bottom: 0, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? GameHeaderCell
        cell?.indicatorColor.backgroundColor = .systemBlue
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {

            let item = self.items[indexPath.row]
            if let id = item.id {
                DEV_ID = id
                
                collectionView.reloadData()
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

                NotificationCenter.default.post(name: .notificationReloadItemGames, object: nil, userInfo: ["developerID" : DEV_ID])
            } else {
                if (item.name == ">") {
                    DEV_PAGE += 1
                }
                
                if (item.name == "<") {
                    DEV_PAGE -= 1
                }
                
                self.LOADING_PAGE = true
                NotificationCenter.default.post(name: .notificationReloadItemGames, object: nil, userInfo: ["loading" : true])

                collectionView.reloadData()
                collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
                
                self.getDevelopers(page: DEV_PAGE)
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? GameHeaderCell
        cell?.indicatorColor.backgroundColor = .clear
    }
}
