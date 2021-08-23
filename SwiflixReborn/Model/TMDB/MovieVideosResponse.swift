//
//  MovieVideosResponse.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 23/08/21.
//

import Foundation

// MARK: - MovieVideosResponse
struct MovieVideosResponse: Codable {
    let id: Int
    let results: [Videos]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case results = "results"
    }
}

// MARK: - Result
struct Videos: Codable {
    let iso639_1: String
    let iso3166_1: String
    let name: String
    let key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt: String
    let _id: String

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name = "name"
        case key = "key"
        case site = "site"
        case size = "size"
        case type = "type"
        case official = "official"
        case publishedAt = "published_at"
        case _id = "id"
    }
}

extension Videos: Media {
    
    var id: Int {
        return -1
    }
    
    
    var mediaTitle: String {
        self.name
    }
    
    var poster: String {
        return ""
    }
    
}
