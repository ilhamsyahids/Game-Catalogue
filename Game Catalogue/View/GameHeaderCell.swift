//
//  GameHeaderCell.swift
//  Game Catalogue
//
//  Created by Ilhamsyahids on 04/10/20.
//  Copyright © 2020 Ilhamsyahids. All rights reserved.
//

import UIKit
import LBTATools

class GameHeaderCell: LBTAListCell<DeveloperListResult> {

    private lazy var titleLabel: UILabel = {
        return UILabel(font: .systemFont(ofSize: 16), textColor: UIColor(named: "textColor") ?? UIColor.systemGray, textAlignment: .center, numberOfLines: 1)
    }()
    lazy var indicatorColor: UIView = {
        return UIView(backgroundColor: .clear)
    }()

    override var item: DeveloperListResult! {
        didSet {
            if item.id == DEV_ID {
                indicatorColor.backgroundColor = .systemBlue
                titleLabel.font = .boldSystemFont(ofSize: 16)
            }
            titleLabel.text = item.name
        }
    }

    override var isSelected: Bool {
        didSet {
            titleLabel.font = isSelected ? .boldSystemFont(ofSize: 16) : .systemFont(ofSize: 16)
            indicatorColor.backgroundColor = isSelected ? .systemBlue : .clear
        }
    }

    override func setupViews() {
        super.setupViews()
        backgroundColor = .clear
        indicatorColor.layer.cornerRadius = 4
        indicatorColor.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        stack(UIView(),
              indicatorColor.withHeight(4)).withMargins(.allSides(0))
        stack(titleLabel)
    }
}
