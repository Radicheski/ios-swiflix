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
