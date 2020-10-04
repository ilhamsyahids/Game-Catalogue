//
//  GameDetail.swift
//  Game Catalogue
//
//  Created by Ilhamsyahids on 04/10/20.
//  Copyright © 2020 Ilhamsyahids. All rights reserved.
//

import Foundation

struct GameDetailResponse: Codable {

    let id: Int?
    let slug: String?
    let name: String?
    let nameOriginal: String?
    let description: String?
    let released: String?
    let tba: Bool?
    let updated: String?
    let backgroundImage: String?
    let website: String?
    let rating: Double?
    let ratingTop: Int?
    let ratings: [GameRatings]?
    let added: Int?
    let playtime: Int?
    let screenshotsCount: Int?
    let moviesCount: Int?
    let creatorsCount: Int?
    let achievementsCount: Int?
    let parentAchievementsCount: Int?
    let redditUrl: String?
    let redditName: String?
    let redditDescription: String?
    let redditLogo: String?
    let redditCount: Int?
    let twitchCount: Int?
    let youtubeCount: Int?
    let reviewsTextCount: Int?
    let ratingsCount: Int?
    let suggestionsCount: Int?
    let alternativeNames: [String]?
    let metacriticUrl: String?
    let parentsCount: Int?
    let additionsCount: Int?
    let gameSeriesCount: Int?
    let reviewsCount: Int?
    let saturatedColor: String?
    let dominantColor: String?
    let platforms: [GamePlatforms]?
    let stores: [GameStores]?
    let developers: [GameDevelopers]?
    let genres: [GameGenres]?
    let tags: [GameTags]?
    let publishers: [GamePublishers]?
    let descriptionRaw: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case slug = "slug"
        case name = "name"
        case nameOriginal = "name_original"
        case description = "description"
        case released = "released"
        case tba = "tba"
        case updated = "updated"
        case backgroundImage = "background_image"
        case website = "website"
        case rating = "rating"
        case ratingTop = "rating_top"
        case ratings = "ratings"
        case added = "added"
        case playtime = "playtime"
        case screenshotsCount = "screenshots_count"
        case moviesCount = "movies_count"
        case creatorsCount = "creators_count"
        case achievementsCount = "achievements_count"
        case parentAchievementsCount = "parent_achievements_count"
        case redditUrl = "reddit_url"
        case redditName = "reddit_name"
        case redditDescription = "reddit_description"
        case redditLogo = "reddit_logo"
        case redditCount = "reddit_count"
        case twitchCount = "twitch_count"
        case youtubeCount = "youtube_count"
        case reviewsTextCount = "reviews_text_count"
        case ratingsCount = "ratings_count"
        case suggestionsCount = "suggestions_count"
        case alternativeNames = "alternative_names"
        case metacriticUrl = "metacritic_url"
        case parentsCount = "parents_count"
        case additionsCount = "additions_count"
        case gameSeriesCount = "game_series_count"
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case platforms = "platforms"
        case stores = "stores"
        case developers = "developers"
        case genres = "genres"
        case tags = "tags"
        case publishers = "publishers"
        case descriptionRaw = "description_raw"
    }
}

struct GamePlatforms: Codable {

    let platformDetail: PlatformDetail?
    let releasedAt: String?
    let requirements: GameDetailRequirements?

    private enum CodingKeys: String, CodingKey {
        case platformDetail = "platform"
        case releasedAt = "released_at"
        case requirements = "requirements"
    }
}

struct PlatformDetail: Codable {

    let id: Int?
    let name: String?
    let slug: String?
}

struct GameDetailRequirements: Codable {

    let minimum: String?
    let recommended: String?

    private enum CodingKeys: String, CodingKey {
        case minimum = "minimum"
        case recommended = "recommended"
    }
}

struct GameDevelopers: Codable {

    let id: Int?
    let name: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }

}

struct GameStores: Codable {

    let id: Int?
    let url: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case url = "url"
    }
}

struct GamePublishers: Codable {

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
