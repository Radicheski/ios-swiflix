struct Dates: Codable {
    let maximum: String
    let minimum: String

    enum CodingKeys: String, CodingKey {
        case maximum = "maximum"
        case minimum = "minimum"
    }
}
