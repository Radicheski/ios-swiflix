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
