struct PersonCreditResponse: Codable {
    let cast: [Cast]
    let crew: [Cast]
    let id: Int

    enum CodingKeys: String, CodingKey {
        case cast = "cast"
        case crew = "crew"
        case id = "id"
    }
}
