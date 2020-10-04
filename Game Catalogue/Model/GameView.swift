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
    
    var isBookmark: Bool {
        loadBookmark()
        for bookmark in gameRealmRes {
            if (bookmark.id == gameRes.id) {
                if bookmark.isBookmarked {
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
    
    func loadBookmark() {
        let listGames = GameRealmResult.get(isBookmarked: true)
        gameRealmRes.append(contentsOf: listGames.reversed())
    }
}
