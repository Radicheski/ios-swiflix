struct PersonImagesResponse: Codable {
    let id: Int
    let profiles: [Profile]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case profiles = "profiles"
    }
}
