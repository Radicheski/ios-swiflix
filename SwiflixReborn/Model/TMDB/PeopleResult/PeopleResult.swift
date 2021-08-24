struct PeopleResult: Codable {
    let adult: Bool
    let gender: Int
    let id: Int
    let knownFor: [KnownFor]
    let knownForDepartment: String
    let name: String
    let popularity: Double
    let profilePath: String

    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case gender = "gender"
        case id = "id"
        case knownFor = "known_for"
        case knownForDepartment = "known_for_department"
        case name = "name"
        case popularity = "popularity"
        case profilePath = "profile_path"
    }
}
