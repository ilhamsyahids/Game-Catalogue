//
//  GameFavoriteCell.swift
//  Game Catalogue
//
//  Created by Ilhamsyahids on 04/10/20.
//  Copyright © 2020 Ilhamsyahids. All rights reserved.
//

import UIKit
import LBTATools
import RealmSwift
import SDWebImage

class GameFavoriteCell: LBTAListCell<GameRealmResult> {

    private lazy var gameImg: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = UIColor(named: "imageBackgroundColor")
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    let nameLabel = UILabel(font: .boldSystemFont(ofSize: 16), textColor: UIColor(named: "textColor") ?? UIColor.systemGray)
    let genreLabel = UILabel(font: .systemFont(ofSize: 14), textColor: UIColor(named: "textColorTwo") ?? UIColor.systemGray)
    let releaseDateLabel = UILabel(text: "-", font: .systemFont(ofSize: 12), textColor: UIColor(named: "textColorTwo") ?? UIColor.systemGray)
    let ratingLabel = UILabel(text: "4.5", font: .systemFont(ofSize: 12), textColor: UIColor(named: "textColorTwo") ?? UIColor.systemGray)
    let favoriteButton = UIButton(image: UIImage(named: "favorite.fill")?.withRenderingMode(.alwaysTemplate) ?? UIImage(), tintColor: UIColor(named: "lipstikColor") ?? UIColor.systemRed)

    override var item: GameRealmResult! {
        didSet {
            gameImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
            if let stringURL = item.backgroundImage {
                gameImg.sd_setImage(with: URL(string: stringURL), placeholderImage: nil, completed: nil)
            }
            nameLabel.text = item.name
            genreLabel.text = item.genres
            releaseDateLabel.text = item.released
            ratingLabel.text = "\(item.rating ) ★"
        }
    }

    override func setupViews() {
        super.setupViews()
        backgroundColor = .clear
        setupGameImage()
        setupFavoriteButton()

        hstack(gameImg,
               UIView().withWidth(16),
               stack(nameLabel,
                     genreLabel,
                     releaseDateLabel,
                     ratingLabel,
                     spacing: 5),
               UIView(),
               stack(favoriteButton,
                     UIView()))
            .withMargins(.allSides(0))
    }

    // MARK: - Private functions
    private func setupGameImage() {
        gameImg.withSize(.init(width: 80, height: 80))
        gameImg.layer.cornerRadius = 8
        gameImg.clipsToBounds = true
    }

    private func setupFavoriteButton() {
        favoriteButton.withWidth(20).withHeight(25)
        favoriteButton.contentVerticalAlignment = .fill
        favoriteButton.contentHorizontalAlignment = .fill
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
    }

    // MARK: - Action
    @objc func favoriteTapped() {
        let object = GameRealmResult()
        object.id = item.id
        object.isFavorite = false
        updateFavorite(object: object)
    }

    private func updateFavorite(realm: Realm = try! Realm(), object: GameRealmResult) {
        do {
            try realm.write {
                realm.add(object, update: .all)
                let parent = parentController as? FavoriteViewController
                parent?.reloadItems()
            }
        } catch let error as NSError {
            print("error update favorite \(error)")
        }
    }

}
