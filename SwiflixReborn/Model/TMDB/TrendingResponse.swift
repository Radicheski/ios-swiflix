//
// Created by Erik Radicheski da Silva on 12/08/21.
//

import Foundation

struct TrendingResponse: Codable {

    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

}

struct Result: Codable {

    let voteAverage: Double
    let overview: String
    let voteCount: Int
    let backdropPath, posterPath: String
    let id: Int
    let name: String?
    let originalLanguage: String
    let genreIDS: [Int]
    let originalName: String?
    let originCountry: [String]?
    let firstAirDate: String?
    let popularity: Double
    let mediaType: MediaType
    let releaseDate: String?
    let adult: Bool?
    let originalTitle: String?
    let video: Bool?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case voteAverage = "vote_average"
        case overview
        case voteCount = "vote_count"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case id, name
        case originalLanguage = "original_language"
        case genreIDS = "genre_ids"
        case originalName = "original_name"
        case originCountry = "origin_country"
        case firstAirDate = "first_air_date"
        case popularity
        case mediaType = "media_type"
        case releaseDate = "release_date"
        case adult
        case originalTitle = "original_title"
        case video, title
    }

}

extension Result: Media {

    var mediaTitle: String {
        self.title ?? "(N/A)"
    }

    var poster: String {
        self.posterPath
    }

}