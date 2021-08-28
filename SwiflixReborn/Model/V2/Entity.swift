class Entity: Codable {
    
    var id: Int
    var name: String
    var posterPath: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodignKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: [.title, .name])
        self.posterPath = try container.decode(String.self, forKey: .profilePath, .posterPath)
        
    }
    
    enum CodignKeys: String, CodingKey {
        
        case id
        
        case name
        case title
        
        case posterPath = "poster_path"
        case profilePath = "profile_path"
        
    }
    
}

extension Entity: Media {
    
    var mediaTitle: String {
        self.name
    }
    
    var poster: String {
        self.posterPath
    }
    
}
