class MediaEntity: Entity {
    
    let overview: String
    let originalName: String
    let releaseDate: String
    let backdropPath: String
    let voteAverage: Double
    
    required init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodignKeys.self)

        self.overview = try container.decode(String.self, forKey: .overview)
        self.originalName = try container.decode(String.self, forKey: .originalName, .originalTitle)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate, .firstAirDate)
        self.backdropPath = try container.decode(String.self, forKey: .backdropPath)
        self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        
        try super.init(from: decoder)
    }
    
    enum CodignKeys: String, CodingKey {
        
        case overview
        
        case originalName = "original_name"
        case originalTitle = "original_title"
        
        case releaseDate = "release_date"
        case firstAirDate = "first_air_date"
        
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        
    }
    
}

class SerieEntity: MediaEntity {
    
    let numberOfSeasons: Int
    let numberOfEpisodes: Int
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.numberOfSeasons = 1
        self.numberOfEpisodes = 1
        
        try super.init(from: decoder)
        
    }
    
    enum CodingKeys: String, CodingKey {
        
        case numberOfSeasons = "number_of_seasons"
        case numberOfEpisodes = "number_of_episodes"
        
    }
    
}
