struct BelongsToCollection: Codable {
    let id: Int
    let name: String
    let posterPath: String
    let backdropPath: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
