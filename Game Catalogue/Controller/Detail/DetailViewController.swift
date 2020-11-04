//
//  DetailViewController.swift
//  Game Catalogue
//
//  Created by Ilhamsyahids on 04/10/20.
//  Copyright © 2020 Ilhamsyahids. All rights reserved.
//

import UIKit
import LBTATools
import SDWebImage

class DetailViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.rowHeight = 44.0
        tableView.register(DetailTableCell.self, forCellReuseIdentifier: "detailTableCell")
        tableView.isHidden = true
        return tableView
    }()

    var gameID = 7689 // Tomb Raider
    var gameName = ""
    var data: GameDetailResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        extendedLayoutIncludesOpaqueBars = true
        setupUI()
        getGameDetail()
    }

    private func setupUI() {
        self.view.backgroundColor = .systemBackground

        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }

    func getGameDetail() {
        showLoadingIndicator(true)
        API.shared.getGameDetail(by: gameID) { [weak self] result in
            guard let self = self else { return }
            self.showLoadingIndicator(false)
            switch result {
            case .success(let games):
                self.updateUI(with: games)
            case .failure(let error):
                self.showAlertOnMainThread(message: error.rawValue)
            }
        }
    }

    private func updateUI(with data: GameDetailResponse) {
        DispatchQueue.main.async {
            self.data = data
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate
extension DetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension DetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailTableCell", for: indexPath) as! DetailTableCell
        cell.delegate = self
        if let data = self.data {
            cell.setData(data)
        }
        return cell
    }
}

// MARK: - DetailTableCellDelegate
extension DetailViewController: DetailTableCellDelegate {

    func arrowRightTapped() {
        let vc = DetailMoreViewController()
        if let data = self.data {
            vc.title = data.name
            vc.updateUI(with: data)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

import SwiftUI

struct DetailViewController_Previews: PreviewProvider {
    static var previews: some View {
        Group {
           DetailContentView().previewDevice(.init(stringLiteral: "iPhone X"))
              .environment(\.colorScheme, .light)

//           DetailContentView().previewDevice(.init(stringLiteral: "iPhone X"))
//            .environment(\.colorScheme, .dark)
        }
    }

    struct DetailContentView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> DetailViewController {
            return DetailViewController()
        }

        func updateUIViewController(_ uiViewController: DetailViewController, context: Context) {
            //
        }
    }
}
