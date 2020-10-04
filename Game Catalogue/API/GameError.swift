//
//  GameError.swift
//  Game Catalogue
//
//  Created by Ilhamsyahids on 04/10/20.
//  Copyright © 2020 Ilhamsyahids. All rights reserved.
//

import Foundation

enum GameError: String, Error {
    
    case invalidResponse = "Invalid response, please try again!"
    case invalidURL = "Invalid URL!"
    case invalidData = "Invalid data!"
    case somethingWrong = "Something went wrong, please try again!"
}
