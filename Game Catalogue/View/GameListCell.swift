//
//  GameListCell.swift
//  Game Catalogue
//
//  Created by Ilhamsyahids on 04/10/20.
//  Copyright © 2020 Ilhamsyahids. All rights reserved.
//

import UIKit
import LBTATools
import SDWebImage
import RealmSwift

class GameListCell: LBTAListCell<GameView> {

    private lazy var gameImg: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = UIColor(named: "imageBackgroundColor")
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    let containerView = UIView(backgroundColor: UIColor(named: "backgroundColor") ?? UIColor.systemBackground)
    let nameLabel = UILabel(font: .boldSystemFont(ofSize: 24), textColor: UIColor(named: "textColor") ?? UIColor.systemGray, numberOfLines: 2)
    let genreLabel = UILabel(font: .systemFont(ofSize: 18), textColor: UIColor(named: "textColorTwo") ?? UIColor.systemGray, numberOfLines: 2)
    let releaseDateLabel = UILabel(text: "-", font: .systemFont(ofSize: 14), textColor: UIColor(named: "textColorTwo") ?? UIColor.systemGray)
    let ratingLabel = UILabel(text: "4.5", font: .systemFont(ofSize: 14), textColor: UIColor(named: "textColorTwo") ?? UIColor.systemGray)
    let favoriteButton = UIButton(image: UIImage(named: "favorite.fill")?.withRenderingMode(.alwaysTemplate) ?? UIImage(), tintColor: UIColor(named: "favoriteButtonColor") ?? UIColor.systemGray)
    let gradientImg = UIImageView(image: UIImage(named: "imgGradient") ?? UIImage(), contentMode: .scaleAspectFill)

    var gamesRealm = [GameRealmResult]()

    override var item: GameView! {
        didSet {
            gameImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
            if let stringURL = item.gameRes.backgroundImage {
                gameImg.sd_setImage(with: URL(string: stringURL), placeholderImage: nil, completed: nil)
            }
            nameLabel.text = item.gameRes.name
            genreLabel.text = item.genres
            releaseDateLabel.text = item.gameRes.released
            ratingLabel.text = "\(item.gameRes.rating ?? 0.0) ★"
            favoriteButton.tintColor = item.isFavorite ? UIColor(named: "lipstikColor") : UIColor(named: "favoriteButtonColor")
        }
    }

    override func setupViews() {
        super.setupViews()
        gameImg.setRounded()
        setupFavoriteButton()
        setupContainerView()
        stack(gameImg)
        setupImageGradient()
        stack(gradientImg,UIView())
        stack(hstack(UIView(),favoriteButton).withMargins(.init(top: -2, left: 0, bottom: 0, right: 8)), UIView(), containerView).withMargins(.allSides(0))
        containerView.stack(nameLabel, genreLabel, containerView.hstack(releaseDateLabel, UIView(), ratingLabel, spacing: 5), spacing: 5).withMargins(.allSides(12))
        makeCardLayout()
    }

    // MARK: - Private function
    private func setupContainerView() {
        containerView.layer.cornerRadius = 13
        containerView.clipsToBounds = true
        containerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }

    private func setupImageGradient() {
        gradientImg.withWidth(self.frame.width)
        gradientImg.withHeight(self.frame.height / 3)
        gradientImg.layer.cornerRadius = 13
        gradientImg.clipsToBounds = true
        gradientImg.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    private func setupFavoriteButton() {
        favoriteButton.withWidth(30).withHeight(36)
        favoriteButton.contentVerticalAlignment = .fill
        favoriteButton.contentHorizontalAlignment = .fill
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
    }

    // MARK: - Action
    @objc func favoriteTapped() {
        let data = GameRealmResult()
        if let id = item.gameRes.id {
            data.id = id
            data.name = item.gameRes.name
            data.backgroundImage = item.gameRes.backgroundImage
            data.genres = item.genres
            data.released = item.gameRes.released
            data.rating = item.gameRes.rating ?? 0
            data.isFavorite = favoriteButton.tintColor == UIColor(named: "lipstikColor") ? false : true
            addFavorite(object: data)
        }
    }

    private func addFavorite(realm: Realm = try! Realm(), object: GameRealmResult) {
        var isFavorite = false
        do {
            try realm.write {
                realm.add(object, update: .all)
                isFavorite = object.isFavorite
                favoriteButton.tintColor = isFavorite ? UIColor(named: "lipstikColor") : UIColor(named: "favoriteButtonColor")
                let parent = parentController as? MainViewController
                parent?.reloadFab()
            }
        } catch let error as NSError {
            print("error save favorite \(error)")
        }
    }

}
