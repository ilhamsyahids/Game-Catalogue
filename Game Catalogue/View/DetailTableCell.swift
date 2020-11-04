//
//  DetailTableCell.swift
//  Game Catalogue
//
//  Created by Ilhamsyahids on 04/10/20.
//  Copyright © 2020 Ilhamsyahids. All rights reserved.
//

import UIKit
import SDWebImage

protocol DetailTableCellDelegate: class {
    func arrowRightTapped()
}

class DetailTableCell: UITableViewCell {

    private let developerLabel = UILabel(font: .boldSystemFont(ofSize: 13), textColor: UIColor(named: "textColor") ?? UIColor.systemGray, numberOfLines: 1)
    private let titleLabel = UILabel(font: .boldSystemFont(ofSize: 22), textColor: UIColor(named: "textColor") ?? UIColor.systemGray, numberOfLines: 0)
    private let releaseDateLabel = UILabel(font: .boldSystemFont(ofSize: 14), textColor: UIColor(named: "textColor") ?? UIColor.systemGray)
    private let imgHeader = UIImageView(image: nil, contentMode: .scaleAspectFill)
    private let aboutLabel = UILabel(text: "About this game", font: .boldSystemFont(ofSize: 18), textColor: UIColor(named: "textColor") ?? UIColor.systemGray)
    private let arrowRightButton = UIButton(image: UIImage(named: "chevron.right") ?? UIImage(), tintColor: UIColor(named: "textColor") ?? UIColor.systemGray)
    private let descLabel = UILabel(font: .systemFont(ofSize: 16), textColor: UIColor(named: "textColor") ?? UIColor.systemGray, numberOfLines: 3)
    private let lineView = UIView(backgroundColor: UIColor(named: "lineColor") ?? UIColor.systemGray)
    private let ratingsLabel = UILabel(text: "Ratings", font: .boldSystemFont(ofSize: 18), textColor: UIColor(named: "textColor") ?? UIColor.systemGray)
    private let vStackView = UIStackView()

    weak var delegate: DetailTableCellDelegate?

    var data: GameDetailResponse?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        imgHeader.backgroundColor = UIColor(named: "imageBackgroundColor")
        aboutLabel.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)

        arrowRightButton.addTarget(self, action: #selector(arrowRightTapped), for: .touchUpInside)
        setupRatingView()

        self.contentView.stack(
            contentView.hstack(
                contentView.stack(developerLabel, titleLabel, releaseDateLabel, spacing: 5),
                UIView(),
                spacing: 3,
                alignment: .center)
                .withMargins(.init(top: 0, left: 20, bottom: 0, right: 20)),
            imgHeader.withHeight(250),
            contentView.stack(
                contentView.hstack(aboutLabel, UIView(), arrowRightButton),
                descLabel,
                lineView.withHeight(1),
                ratingsLabel,
                vStackView,
                spacing: 20)
                .withMargins(.init(top: 0, left: 20, bottom: 0, right: 20)),
            spacing: 20)
            .withMargins(.init(top: 20, left: 0, bottom: 20, right: 0))
    }

    private func setupRatingView() {
        vStackView.axis = .vertical
        vStackView.spacing = 8
    }

    func setData(_ data: GameDetailResponse) {
        self.data = data
        imgHeader.sd_imageIndicator = SDWebImageActivityIndicator.gray
        if let imageURL = data.backgroundImage {
            imgHeader.sd_setImage(with: URL(string: imageURL), placeholderImage: nil, completed: nil)
        }
        titleLabel.text = data.name
        descLabel.attributedText = data.description?.htmlToAttributedString
        releaseDateLabel.text = data.released
        if let developers = data.developers {
            for developer in developers {
                developerLabel.text = developer.name
            }
        }
        if let ratings = data.ratings, ratings.count > 0 {
            for rating in ratings {
                let hStackView = UIStackView()
                hStackView.axis = .horizontal
                hStackView.spacing = 8
                hStackView.alignment = .center

                let ratingName = UILabel(font: .systemFont(ofSize: 14), textColor: UIColor(named: "textColor") ?? UIColor.systemGray)
                
                let progressView = UIProgressView()
                progressView.progressViewStyle = .bar
                progressView.progressTintColor = .systemGreen
                progressView.backgroundColor = .systemGray5
                progressView.layer.cornerRadius = 3
                progressView.clipsToBounds = true
                progressView.transform = CGAffineTransform(scaleX: 1, y: 3)
                
                ratingName.text = rating.title?.capitalized
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 1.0) {
                        progressView.setProgress(Float(rating.percent ?? 0.0) / 100, animated: true)
                    }
                }

                hStackView.addArrangedSubview(ratingName.withWidth(150))
                hStackView.addArrangedSubview(progressView)

                vStackView.addArrangedSubview(hStackView)
            }
            vStackView.layoutIfNeeded()
        }
        else {
            ratingsLabel.isHidden = true
        }
    }

    // MARK: - Actions
    @objc func arrowRightTapped() {
        delegate?.arrowRightTapped()
    }
}
