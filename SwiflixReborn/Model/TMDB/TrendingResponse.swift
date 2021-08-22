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
    
    let _name: String?
    let firstAirDate: String?
    let posterPath: String?
    let originalName: String?
    let originCountry: [String]?
    let voteAverage: Double?
    let overview: String?
    let id: Int
    let backdropPath: String?
    let voteCount: Int?
    let genreIds: [Int]?
    let originalLanguage: String?
    let popularity: Double
    let mediaType: MediaType?
    let video: Bool?
    let releaseDate: String?
    let adult: Bool?
    let title: String?
    let originalTitle: String?
    
    let gender: Int?
    let knownForDepartment: String?
    let profilePath: String?
    let knownFor: [KnownFor]?

    enum CodingKeys: String, CodingKey {
        case _name = "name"
        case firstAirDate = "first_air_date"
        case posterPath = "poster_path"
        case originalName = "original_name"
        case originCountry = "origin_country"
        case voteAverage = "vote_average"
        case overview = "overview"
        case id = "id"
        case backdropPath = "backdrop_path"
        case voteCount = "vote_count"
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
        case popularity = "popularity"
        case mediaType = "media_type"
        case video = "video"
        case releaseDate = "release_date"
        case adult = "adult"
        case title = "title"
        case originalTitle = "original_title"
        
        case gender = "gender"
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
        case knownFor = "known_for"
        
    }

}

// MARK: - KnownFor
struct KnownFor: Codable {
    let voteAverage: Double
    let title: String?
    let releaseDate: String?
    let mediaType: String
    let popularity: Double?
    let adult: Bool?
    let backdropPath: String?
    let overview: String
    let genreIds: GenreIdsUnion
    let voteCount: Int
    let originalLanguage: String
    let originalTitle: String?
    let posterPath: String?
    let id: Int
    let video: Bool?
    let originalName: String?
    let name: String?
    let originCountry: [String]?
    let firstAirDate: String?

    enum CodingKeys: String, CodingKey {
        case voteAverage = "vote_average"
        case title = "title"
        case releaseDate = "release_date"
        case mediaType = "media_type"
        case popularity = "popularity"
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case overview = "overview"
        case genreIds = "genre_ids"
        case voteCount = "vote_count"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case id = "id"
        case video = "video"
        case originalName = "original_name"
        case name = "name"
        case originCountry = "origin_country"
        case firstAirDate = "first_air_date"
    }
}

enum GenreIdsUnion: Codable {
    case genreIdsClass(GenreIdsClass)
    case integerArray([Int])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
            return
        }
        if let x = try? container.decode(GenreIdsClass.self) {
            self = .genreIdsClass(x)
            return
        }
        throw DecodingError.typeMismatch(GenreIdsUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for GenreIdsUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .genreIdsClass(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - GenreIdsClass
struct GenreIdsClass: Codable {
}

extension Result: Media {

    var mediaTitle: String {
        self.title ?? self._name ?? "(No title)"
    }

    var poster: String {
        self.posterPath ?? ""
    }
    
}

extension Result: Person {
    
    var name: String {
        self._name ?? "(No name)"
    }
    
    var profile: String {
        self.profilePath ?? ""
    }
    
    
}
