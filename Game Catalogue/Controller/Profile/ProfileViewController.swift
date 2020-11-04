//
//  ProfileViewController.swift
//  Game Catalogue
//
//  Created by Ilhamsyahids on 04/10/20.
//  Copyright © 2020 Ilhamsyahids. All rights reserved.
//

import UIKit
import LBTATools

class AboutViewController: UIViewController {

    private let imgProfile = UIImageView(image: UIImage(named: "profile"), contentMode: .scaleAspectFill)
    private let nameLabel: UILabel =
        UILabel(text: "Ilham Syahid S", font: .boldSystemFont(ofSize: 16), textColor: UIColor(named: "textColor") ?? UIColor.systemGray)
    private let addressLabel: UILabel =
        UILabel(font: .systemFont(ofSize: 14), textColor: UIColor(named: "textColor") ?? UIColor.systemGray)
    private let emailLabel: UILabel =
        UILabel(text: "ilhamsyahids@gmail.com", font: .systemFont(ofSize: 14), textColor: UIColor(named: "textColor") ?? UIColor.systemGray)
    let editButton = UIButton(title: "Edit", titleColor: .systemBlue)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setData()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        imgProfile.layer.cornerRadius = 130 / 2
        view.stack(view.stack(imgProfile.withWidth(130).withHeight(130),
                              alignment: .center)
            .withMargins(.init(top: 0, left: 0, bottom: 20, right: 0)),
                   view.hstack(nameLabel,UIView(),editButton),
                   emailLabel,
                   addressLabel,
                   UIView().withHeight(12),
                   UIView(),
                   spacing: 8)
            .withMargins(.init(top: 20, left: 23, bottom: 0, right: 23))

        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }

    private func setData() {
        addressLabel.text = User.instance.userCity
    }

    // MARK: - Actions
    @objc func editButtonTapped() {
        let vc = EditProfileViewController()
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
}

#if DEBUG
import SwiftUI

struct AboutViewController_Previews: PreviewProvider {
    static var previews: some View {
        Group {
           AboutContentView().previewDevice(.init(stringLiteral: "iPhone X"))
              .environment(\.colorScheme, .light)
//           AboutContentView().previewDevice(.init(stringLiteral: "iPhone X"))
//              .environment(\.colorScheme, .dark)
        }
    }

    struct AboutContentView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> AboutViewController {
            return AboutViewController()
        }

        func updateUIViewController(_ uiViewController: AboutViewController, context: Context) {
            //
        }
    }
}
#endif
