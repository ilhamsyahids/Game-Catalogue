//
//  MainViewController.swift
//  Game Catalogue
//
//  Created by Ilhamsyahids on 04/10/20.
//  Copyright © 2020 Ilhamsyahids. All rights reserved.
//

import Foundation
import LBTATools

class MainViewController: LBTAListController<GameListCell, GameView> {

    let headerController = MainHeaderViewController(scrollDirection: .horizontal)
    
    var hasMorePage = false
    var isRequesting = false

    private var devID = 0
    private var page = 1

    lazy var floatingActionButton: UIButton = {
        let fab = UIButton()
        fab.isHidden = true
        fab.backgroundColor = .systemBlue
        fab.setImage(UIImage(named: "favorite.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        fab.tintColor = .white
        fab.translatesAutoresizingMaskIntoConstraints = false
        return fab
    }()

    var bottomFabConstraint: NSLayoutConstraint!

    var isFirstLaunch = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        reloadFab()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadItemGames), name: .notificationReloadItemGames, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadFab), name: .notificationReloadFab, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    private func setupUI() {
        showLoadingIndicator(true)
        self.collectionView.backgroundColor = .systemBackground
        self.collectionView.contentInset = .init(top: 75, left: 16, bottom: 100, right: 16)
        self.collectionView.scrollIndicatorInsets = .init(top: 55, left: 0, bottom: 25, right: 0)
        setupNavBar()

        self.view.addSubview(headerController.view)
        headerController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            headerController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            headerController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            headerController.view.heightAnchor.constraint(equalToConstant: 65),
        ])
        headerController.collectionView.showsHorizontalScrollIndicator = false

        // Floating action button
        self.view.addSubview(floatingActionButton)
        bottomFabConstraint = NSLayoutConstraint(item: floatingActionButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1.0, constant: -22)
        NSLayoutConstraint.activate([
            bottomFabConstraint,
            floatingActionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -22),
            floatingActionButton.heightAnchor.constraint(equalToConstant: 50),
            floatingActionButton.widthAnchor.constraint(equalToConstant: 50),
        ])
        floatingActionButton.makeCardLayout(cornerRadius: 25, shadowRadius: 4.0, shadowOpacity: 3.0)
        floatingActionButton.addTarget(self, action: #selector(fabTapped), for: .touchUpInside)
    }

    private func setupNavBar() {
        self.title = "Home"
        self.navigationController?.navigationBar.barTintColor = .systemBackground
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "person.crop.circle"), style: .plain, target: self, action: #selector(profileTapped(_:)))
    }

    @objc func reloadItemGames(notification: NSNotification) {
        if let loading = (notification.userInfo?["loading"]) as? Bool {
            showLoadingIndicator(loading, withBlocking: true)
        }
        guard let developerID = notification.userInfo?["developerID"] as? Int else { return }
        devID = developerID
        page = 1
        getGamesByDeveloper(id: developerID, page: page)
    }

    @objc func reloadFab() {
        let listOfGames = GameRealmResult.get(isFavorite: true)
        UIView.animate(withDuration: 0.5) {
            if listOfGames.count > 0 {
                if !self.isFirstLaunch {
                    self.floatingActionButton.isHidden = false
                } else {
                    self.showFab()
                }
            } else {
                self.hideFab()
            }
        }
        isFirstLaunch = true
    }

    private func showFab() {
        UIView.animate(withDuration: 0.5) {
            self.floatingActionButton.alpha = 1
            self.bottomFabConstraint.constant = 10
            self.floatingActionButton.isHidden = false
            self.view.layoutIfNeeded()
        }
    }

    private func hideFab() {
        UIView.animate(withDuration: 1) {
            self.floatingActionButton.alpha = 0
            self.bottomFabConstraint.constant = -70
            self.view.layoutIfNeeded()
        }
    }

    private func getGamesByDeveloper(id developersID: Int = 0, page: Int) {
        showLoadingIndicator(true, withBlocking: page == 1 ? true : false)

        API.shared.getGamesByDeveloper(id: developersID, page: page) { [weak self] result in
            guard let self = self else { return }
            self.showLoadingIndicator(false, withBlocking: page == 1 ? true : false)

            switch result {
            case .success(let games):
                self.updateUI(with: games, page: page)
            case .failure(let error):
                self.showAlertOnMainThread(message: error.rawValue)
            }

            self.isRequesting = false
        }
    }

    private func updateUI(with data: GameResponse, page: Int) {
        if let results = data.results, !results.isEmpty {
            hasMorePage = data.next != nil ? true : false
            if page == 1 {
                items.removeAll()
            }
            for result in results {
                let data = GameView(data: result)
                self.items.append(data)
             }
            DispatchQueue.main.async {
                if page == 1 {
                    self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                }
                self.collectionView.reloadData()
            }
        } else {
            DispatchQueue.main.async {
                self.showAlertOnMainThread(message: "Sorry, data is empty :(")
            }
        }
    }

    // MARK: - Actions
    @objc func searchTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.pushViewController(SearchViewController(), animated: false)
    }

    @objc func profileTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.pushViewController(AboutViewController(), animated: true)
    }

    @objc func fabTapped() {
        self.navigationController?.pushViewController(FavoriteViewController(), animated: true)
    }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.items.count - 1 {
            if hasMorePage {
                if !isRequesting {
                    isRequesting = true
                    page += 1
                    getGamesByDeveloper(id: devID, page: page)
                }
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 32
        return .init(width: width, height: width + 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        guard let id = items[indexPath.row].gameRes.id else { return }
        vc.gameID = id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

#if DEBUG
import SwiftUI

struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        Group {
          ContentView().previewDevice(.init(stringLiteral: "iPhone X"))
             .environment(\.colorScheme, .light)

        //    ContentView().previewDevice(.init(stringLiteral: "iPhone X"))
        //       .environment(\.colorScheme, .dark)
        }
    }

    struct ContentView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> MainViewController {
            return MainViewController()
        }

        func updateUIViewController(_ uiViewController: MainViewController, context: Context) {
            //
        }
    }
}
#endif
