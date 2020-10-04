//
//  Game.swift
//  Game Catalogue
//
//  Created by Ilhamsyahids on 04/10/20.
//  Copyright © 2020 Ilhamsyahids. All rights reserved.
//

import Foundation
import RealmSwift

struct GameResponse: Codable {

    let count: Int?
    let next: String?
    let previous: String?
    var results: [GameResults]?
    let userPlatforms: Bool?

    private enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case results = "results"
        case userPlatforms = "user_platforms"
    }
}

class GameRealmResult: Object {

    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var backgroundImage: String?
    @objc dynamic var genres: String?
    @objc dynamic var released: String?
    @objc dynamic var rating: Double = 0.0
    @objc dynamic var isBookmarked: Bool = false

    override static func primaryKey() -> String? {
        return "id"
    }

    static func get(realm: Realm = try! Realm(), isBookmarked: Bool = false) -> Results<GameRealmResult> {
        let newsList: Results<GameRealmResult> = realm.objects(GameRealmResult.self)
        if isBookmarked {
            return newsList.filter("isBookmarked == true")
        }
        return newsList
    }

}

struct GameResults: Codable {

    let slug: String?
    let name: String?
    let playtime: Int?
    let released: String?
    let tba: Bool?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Int?
    let ratings: [GameRatings]?
    let ratingsCount: Int?
    let reviewsTextCount: Int?
    let added: Int?
    let suggestionsCount: Int?
    let id: Int?
    let genres: [GameGenres]?
    let tags: [GameTags]?
    let reviewsCount: Int?
    let communityRating: Int?
    let saturatedColor: String?
    let dominantColor: String?
    let shortScreenshots: [GameShortScreenshots]?
    var isBookmarked: Bool?

    private enum CodingKeys: String, CodingKey {
        case slug = "slug"
        case name = "name"
        case playtime = "playtime"
        case released = "released"
        case tba = "tba"
        case backgroundImage = "background_image"
        case rating = "rating"
        case ratingTop = "rating_top"
        case ratings = "ratings"
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added = "added"
        case suggestionsCount = "suggestions_count"
        case id = "id"
        case genres = "genres"
        case tags = "tags"
        case reviewsCount = "reviews_count"
        case communityRating = "community_rating"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case shortScreenshots = "short_screenshots"
    }
}

struct GameShortScreenshots: Codable {

    let id: Int?
    let image: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case image = "image"
    }
}

struct GameGenres: Codable {

    let id: Int?
    let name: String?
    let slug: String?
    let gamesCount: Int?
    let imageBackground: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case slug = "slug"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

struct GameRatings: Codable {

    let id: Int?
    let title: String?
    let count: Int?
    let percent: Double?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case count = "count"
        case percent = "percent"
    }
}

struct GameTags: Codable {

    let id: Int?
    let name: String?
    let slug: String?
    let language: String?
    let gamesCount: Int?
    let imageBackground: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case slug = "slug"
        case language = "language"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}
