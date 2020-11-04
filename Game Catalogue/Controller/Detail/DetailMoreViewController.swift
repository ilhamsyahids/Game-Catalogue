//
//  DetailMoreViewController.swift
//  Game Catalogue
//
//  Created by Ilhamsyahids on 04/10/20.
//  Copyright © 2020 Ilhamsyahids. All rights reserved.
//

import UIKit

class DetailMoreViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let aboutLabel = UILabel(text: "About this game", font: .boldSystemFont(ofSize: 18), textColor: UIColor(named: "textColor") ?? UIColor.systemGray)
    private let descLabel = UILabel(font: .systemFont(ofSize: 16), textColor: UIColor(named: "textColor") ?? UIColor.systemGray, numberOfLines: 0)
    private let lineView = UIView(backgroundColor: UIColor(named: "lineColor") ?? UIColor.systemGray)
    private let platformLabel = UILabel(text: "Available platforms", font: .boldSystemFont(ofSize: 18), textColor: UIColor(named: "textColor") ?? UIColor.systemGray)
    private let platformSV = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])

        let heightConstraint = containerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = UILayoutPriority(rawValue: 250)
        scrollView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            heightConstraint,
        ])

        platformSV.axis = .vertical
        platformSV.spacing = 8
        containerView.stack(aboutLabel,
                            descLabel,
                            lineView.withHeight(1),
                            platformLabel,
                            platformSV,
                            spacing: 12)
            .withMargins(.init(top: 20, left: 20, bottom: 0, right: 20))
    }

    func updateUI(with data: GameDetailResponse) {
        descLabel.attributedText = data.description?.htmlToAttributedString
        if let platforms = data.platforms {
            for platform in platforms {
                let platformTitle = UILabel(font: .boldSystemFont(ofSize: 16), textColor: UIColor(named: "textColor") ?? UIColor.systemGray)
                let minReqLabel = UILabel(numberOfLines: 0)
                let recommenReqLabel = UILabel(numberOfLines: 0)

                platformTitle.text = platform.platformDetail?.name

                let minReq = platform.requirements?.minimum?
                    .replacingOccurrences(of: "<br>", with: "")
                    .replacingOccurrences(of: "<ul class=\"bb_ul\">", with: "")
                    .replacingOccurrences(of: "</ul>", with: "")
                let recommenReq = platform.requirements?.recommended?
                    .replacingOccurrences(of: "<br>", with: "")
                    .replacingOccurrences(of: "<ul class=\"bb_ul\">", with: "")
                    .replacingOccurrences(of: "</ul>", with: "")
                minReqLabel.attributedText = minReq?.htmlToAttributedString
                recommenReqLabel.attributedText = recommenReq?.htmlToAttributedString
                platformSV.addArrangedSubview(platformTitle)
                platformSV.addArrangedSubview(minReqLabel)
                platformSV.addArrangedSubview(recommenReqLabel)
            }
        }
    }

}
