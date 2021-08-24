struct Cast: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String?
    let overview: String
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int
    let popularity: Double
    let character: String?
    let creditId: String
    let order: Int?
    let mediaType: MediaType
    let name: String?
    let firstAirDate: String?
    let originalName: String?
    let originCountry: [String]?
    let episodeCount: Int?
    let department: String?
    let job: String?

    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id = "id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case popularity = "popularity"
        case character = "character"
        case creditId = "credit_id"
        case order = "order"
        case mediaType = "media_type"
        case name = "name"
        case firstAirDate = "first_air_date"
        case originalName = "original_name"
        case originCountry = "origin_country"
        case episodeCount = "episode_count"
        case department = "department"
        case job = "job"
    }
}
