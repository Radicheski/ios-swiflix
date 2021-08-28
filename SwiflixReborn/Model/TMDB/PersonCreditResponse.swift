struct PersonCreditResponse: Codable {
    let cast: [Entity]
    let crew: [Entity]
    let id: Int

    enum CodingKeys: String, CodingKey {
        case cast = "cast"
        case crew = "crew"
        case id = "id"
    }
}
