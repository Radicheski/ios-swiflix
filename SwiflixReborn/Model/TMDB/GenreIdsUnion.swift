enum GenreIdsUnion: Codable {
    case genreIdsClass(GenreIdsClass)
    case integerArray([Int])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([Int].self) {
            self = .integerArray(x)
            return
        }
        if let x = try? container.decode(GenreIdsClass.self) {
            self = .genreIdsClass(x)
            return
        }
        throw DecodingError.typeMismatch(GenreIdsUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for GenreIdsUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .genreIdsClass(let x):
            try container.encode(x)
        case .integerArray(let x):
            try container.encode(x)
        }
    }
}
