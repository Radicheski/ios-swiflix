class PersonEntity: Entity {
    
    let biography: String
    let birthday: String?
    let placeOfBirth: String
    let deathday: String?
    let knownForDepartment: String
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.biography = try container.decode(String.self, forKey: .biography)
        self.birthday = try? container.decode(String.self, forKey: .birthday)
        self.placeOfBirth = try container.decode(String.self, forKey: .placeOfBirth)
        self.deathday = try? container.decode(String.self, forKey: .deathday)
        self.knownForDepartment = try container.decode(String.self, forKey: .knownForDepartment)
        
        try super.init(from: decoder)
    }
    
    enum CodingKeys: String, CodingKey {
        
        case biography
        case birthday
        case placeOfBirth = "place_of_birth"
        case deathday
        case knownForDepartment = "known_for_department"
        
    }
    
}
