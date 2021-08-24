struct Network: Codable {
    let name: String
    let id: Int
    let logoPath: String
    let originCountry: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}
