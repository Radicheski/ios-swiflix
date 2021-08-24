//
//  MovieReviewResponse.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 21/08/21.
//

import Foundation

// MARK: - Result
struct Review: Codable {
    let author: String
    let authorDetails: AuthorDetails
    let content: String
    let createdAt: String
    let id: String
    let updatedAt: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case author = "author"
        case authorDetails = "author_details"
        case content = "content"
        case createdAt = "created_at"
        case id = "id"
        case updatedAt = "updated_at"
        case url = "url"
    }
}

// MARK: - AuthorDetails
struct AuthorDetails: Codable {
    let name: String
    let username: String
    let avatarPath: String?
    let rating: Int?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case username = "username"
        case avatarPath = "avatar_path"
        case rating = "rating"
    }
}
