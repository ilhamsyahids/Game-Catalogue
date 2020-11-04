//
//  DeveloperList.swift
//  Game Catalogue
//
//  Created by Ilhamsyahids on 04/10/20.
//  Copyright © 2020 Ilhamsyahids. All rights reserved.
//

import Foundation

struct DeveloperList: Codable {
    let results: [DeveloperListResult]?
    let prev: String?
    let next: String?
    let count: Int?
    
    private enum CodingKeys: String, CodingKey {
        case results = "results"
        case prev = "previous"
        case next = "next"
        case count = "count"
    }
}

struct DeveloperListResult: Codable {
    let id: Int?
    let name: String?
    
    init(_ name: String) {
        self.name = name
        self.id = nil
    }
}
