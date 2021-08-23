//
//  PersonImagesResponse.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 23/08/21.
//

import Foundation

// MARK: - PersonImagesResponse
struct PersonImagesResponse: Codable {
    let id: Int
    let profiles: [Profile]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case profiles = "profiles"
    }
}

// MARK: - Profile
struct Profile: Codable {
    let aspectRatio: Double
    let height: Int
    let iso639_1: String?
    let filePath: String
    let voteAverage: Double
    let voteCount: Int
    let width: Int

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case height = "height"
        case iso639_1 = "iso_639_1"
        case filePath = "file_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width = "width"
    }
}

extension Profile: Media {
    //TODO Delete this extension
    
    var id: Int {
        return -1
    }
    
    var mediaTitle: String {
        return ""
    }
    
    var poster: String {
        self.filePath
    }
    

}
