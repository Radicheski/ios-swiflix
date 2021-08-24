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
