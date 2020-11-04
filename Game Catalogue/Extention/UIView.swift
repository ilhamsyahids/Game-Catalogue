//
//  UIView.swift
//  Game Catalogue
//
//  Created by Ilhamsyahids on 04/10/20.
//  Copyright © 2020 Ilhamsyahids. All rights reserved.
//

import UIKit

extension UIView {

    func makeCardLayout(cornerRadius: CGFloat = 13, shadowRadius: CGFloat = 15, shadowOpacity: Float = 0.5) {
        layer.shadowColor = UIColor.init(white: 0, alpha: 0.5).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3.0)
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
    }
}
