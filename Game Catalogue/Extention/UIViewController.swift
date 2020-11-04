//
//  UIViewController.swift
//  Game Catalogue
//
//  Created by Ilhamsyahids on 04/10/20.
//  Copyright © 2020 Ilhamsyahids. All rights reserved.
//

import UIKit

private let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
private var containerIndicator: UIView!

extension UIViewController {

    func showLoadingIndicator(_ isShown: Bool, withBlocking: Bool = false) {
        DispatchQueue.main.async {
            if withBlocking {
                if isShown {
                    containerIndicator = UIView(frame: .zero)
                    containerIndicator.backgroundColor = UIColor(named: "indicatorBlockerColor")
                    self.view.addSubview(containerIndicator)
                    containerIndicator.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint.activate([
                        containerIndicator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                        containerIndicator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                        containerIndicator.topAnchor.constraint(equalTo: self.view.topAnchor),
                        containerIndicator.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                    ])
                    activityIndicator.color = .systemGray
                    activityIndicator.center = self.view.center
                    containerIndicator.addSubview(activityIndicator)
                    activityIndicator.startAnimating()
                } else {
                    containerIndicator.subviews.forEach({ $0.removeFromSuperview() })
                    containerIndicator.removeFromSuperview()
                    activityIndicator.stopAnimating()
                }
            }
            else {
                activityIndicator.color = .systemGray
                activityIndicator.center = self.view.center
                if isShown {
                    self.view.addSubview(activityIndicator)
                    activityIndicator.startAnimating()
                } else {
                    self.view.willRemoveSubview(activityIndicator)
                    activityIndicator.stopAnimating()
                }
            }
        }
    }

    func showAlertOnMainThread(message: String, title: String = "") {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
