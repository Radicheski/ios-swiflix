struct TMDBResponse<T>: Codable where T: Codable {

    var dates: Dates?
    var page: Int?
    var id: Int?
    var results: [T]
    var totalPages: Int?
    var totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case dates
        case page
        case id
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

}
