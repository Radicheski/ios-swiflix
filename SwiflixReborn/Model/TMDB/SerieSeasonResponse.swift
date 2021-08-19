//
//  SerieSeasonResponse.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 19/08/21.
//

import Foundation

// MARK: - SerieSeasonResponse
struct SerieSeasonResponse: Codable {
    let id: String
    let airDate: String
    let episodes: [Episode]
    let name: String
    let overview: String
    let serieSeasonResponseId: Int
    let posterPath: String
    let seasonNumber: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case airDate = "air_date"
        case episodes = "episodes"
        case name = "name"
        case overview = "overview"
        case serieSeasonResponseId = "id"
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}

// MARK: - Episode
struct Episode: Codable {
    let airDate: String
    let episodeNumber: Int
    let crew: [Crew]
    let guestStars: [Crew]
    let id: Int
    let name: String
    let overview: String
    let productionCode: String
    let seasonNumber: Int
    let stillPath: String?
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case crew = "crew"
        case guestStars = "guest_stars"
        case id = "id"
        case name = "name"
        case overview = "overview"
        case productionCode = "production_code"
        case seasonNumber = "season_number"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Crew
struct Crew: Codable {
    let job: String?
    let department: String?
    let creditId: String
    let adult: Bool
    let gender: Int
    let id: Int
    let knownForDepartment: String
    let name: String
    let originalName: String
    let popularity: Double
    let profilePath: String?
    let character: String?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case job = "job"
        case department = "department"
        case creditId = "credit_id"
        case adult = "adult"
        case gender = "gender"
        case id = "id"
        case knownForDepartment = "known_for_department"
        case name = "name"
        case originalName = "original_name"
        case popularity = "popularity"
        case profilePath = "profile_path"
        case character = "character"
        case order = "order"
    }
}
