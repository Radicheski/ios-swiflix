//
//  TMDBResponse.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 24/08/21.
//

import Foundation

struct TMDBResponse<T>: Codable where T: Codable {

    var dates: Dates?
    var page: Int?
    var id: Int?
    var results: [T]
    var totalPages: Int?
    var totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case dates
        case page
        case id
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

}
