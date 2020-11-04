//
//  User.swift
//  Game Catalogue
//
//  Created by Ilhamsyahids on 04/10/20.
//  Copyright © 2020 Ilhamsyahids. All rights reserved.
//

import Foundation

class User {

    static let keyCityUser = "keyCityUser"
    static let instance = User()

    let userDefaults: UserDefaults

    private init() {
        self.userDefaults = UserDefaults.standard
    }

    var userCity: String {
        get {
            if let userCity = userDefaults.object(forKey: User.keyCityUser) as? String {
                return userCity
            } else {
                return "Bandung"
            }
        }
        set(userCity) {
            userDefaults.set(userCity, forKey:  User.keyCityUser)
        }
    }
}
