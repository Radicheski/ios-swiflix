extension People: Requestable {
    
    var path: String {
        get {
            switch self {
            case .popular(_): return "/person/popular"
            case .details(let id, _): return "/person/\(id.value)"
            case .combineCredits(let id, _): return "/person/\(id.value)/combined_credits"
            case .images(let id, _): return "/person/\(id.value)/images"
            case .search(_, _): return "/search/person"
            }
        }
    }
    
    var parameters: [RequestParameter] {
        get {
            switch self {
            case .popular(let parameters),
                 .details(_, let parameters),
                 .combineCredits(_, let parameters),
                 .images(_, let parameters),
                 .search(_, let parameters):
                return parameters
            }
        }
    }
    
}
