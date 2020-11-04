//
//  GameView.swift
//  Game Catalogue
//
//  Created by Ilhamsyahids on 04/10/20.
//  Copyright © 2020 Ilhamsyahids. All rights reserved.
//

import Foundation

class GameView {
    var gameRes: GameResults
    var gameRealmRes = [GameRealmResult]()
    
    var genres: String {
        if let genre = gameRes.genres {
            return genre.map{ $0.name ?? "" }.joined(separator: ", ")
        }
        return ""
    }
    
    var isFavorite: Bool {
        loadFavorite()
        for favorite in gameRealmRes {
            if (favorite.id == gameRes.id) {
                if favorite.isFavorite {
                    return true
                } else {
                    return false
                }
            }
        }
        
        return false
    }
    
    init(data: GameResults) {
        self.gameRes = data
    }
    
    func loadFavorite() {
        let listGames = GameRealmResult.get(isFavorite: true)
        gameRealmRes.append(contentsOf: listGames.reversed())
    }
}
