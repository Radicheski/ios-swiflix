class Entity: Codable {
    
    let id: Int
    let name: String
    let posterPath: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodignKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: [.title, .name])
        
        if let poster = try? container.decode(String.self, forKey: .profilePath, .posterPath) {
            self.posterPath = poster
        } else {
            self.posterPath = ""
        }
        
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

extension Entity: Person {
    
    var profile: String {
        self.posterPath
    }
    
}
