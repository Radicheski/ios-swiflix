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
