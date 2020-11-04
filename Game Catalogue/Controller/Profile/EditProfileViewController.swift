//
//  EditProfileViewController.swift
//  Game Catalogue
//
//  Created by Ilhamsyahids on 04/10/20.
//  Copyright © 2020 Ilhamsyahids. All rights reserved.
//

import Foundation
import UIKit
import LBTATools

class EditProfileViewController: LBTAFormController {

    let imageProfile = UIImageView()
    let nameLabel = UILabel(text: "Name", font: .systemFont(ofSize: 16), textColor: UIColor(named: "textColor") ?? UIColor.systemGray)
    let emailLabel = UILabel(text: "Email", font: .systemFont(ofSize: 16), textColor: UIColor(named: "textColor") ?? UIColor.systemGray)
    let cityLabel = UILabel(text: "City", font: .systemFont(ofSize: 16), textColor: UIColor(named: "textColor") ?? UIColor.systemGray)

    let nameTextField = IndentedTextField(placeholder: "Ilham Syahid S")
    let emailTextField = IndentedTextField(placeholder: "ilhamsyahids@gmail.com")
    let cityTextField = IndentedTextField(placeholder: "City", padding: 8)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavBar()
    }

    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        formContainerStackView.axis = .vertical
        formContainerStackView.layoutMargins = .init(top: 40, left: 25, bottom: 25, right: 25)
        formContainerStackView.spacing = 25

        nameTextField.isEnabled = false
        nameTextField.withWidth(UIScreen.main.bounds.width - 70 - 50)
        let hStackView = UIStackView(arrangedSubviews: [nameLabel.withWidth(70), nameTextField, UIView()])
        
        emailTextField.isEnabled = false
        emailTextField.withWidth(UIScreen.main.bounds.width - 70 - 50)
        let hStackViewEmail = UIStackView(arrangedSubviews: [emailLabel.withWidth(70), emailTextField, UIView()])
        
        cityTextField.text = User.instance.userCity
        cityTextField.borderStyle = .roundedRect
        cityTextField.withWidth(UIScreen.main.bounds.width - 70 - 50)
        cityTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        let hStackViewCity = UIStackView(arrangedSubviews: [cityLabel.withWidth(70), cityTextField, UIView()])

        formContainerStackView.addArrangedSubview(hStackView)
        formContainerStackView.addArrangedSubview(hStackViewEmail)
        formContainerStackView.addArrangedSubview(hStackViewCity)
    }

    private func setupNavBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
        self.title = "Edit Profile"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }

    // MARK: - Actions
    @objc fileprivate func cancelTapped() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc fileprivate func doneTapped() {
        if let city = cityTextField.text {
            User.instance.userCity = city
        }
         self.dismiss(animated: true, completion: nil)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == cityTextField || textField == emailTextField {
            if textField.text == "" || cityTextField.text == User.instance.userCity {
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            } else {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            }
        }
    }
}

#if DEBUG
import SwiftUI

struct EditViewController_Previews: PreviewProvider {
    static var previews: some View {
        Group {
           EditContentView().previewDevice(.init(stringLiteral: "iPhone X"))
              .environment(\.colorScheme, .light)

//           EditContentView().previewDevice(.init(stringLiteral: "iPhone X"))
//              .environment(\.colorScheme, .dark)
        }
    }

    struct EditContentView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> EditProfileViewController {
            return EditProfileViewController()
        }

        func updateUIViewController(_ uiViewController: EditProfileViewController, context: Context) {
            //
        }
    }
}
#endif
