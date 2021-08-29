extension TV: Requestable {
    
    var path: String {
        get {
            switch self {
            case .popular(_): return "/tv/popular"
            case .details(let id, _): return "/tv/\(id.value)"
            case .similar(let id, _): return "/tv/\(id.value)/similar"
            case .reviews(let id, _): return "/tv/\(id.value)/reviews"
            case .season(let id, let season, _): return "/tv/\(id.value)/season/\(season.value)"
            case .search(_, _): return "/search/tv"
            }
        }
    }
    
    var parameters: [RequestParameter] {
        get {
            switch self {
            case .popular(let parameters),
                 .details(_, let parameters),
                 .similar(_, let parameters),
                 .reviews(_, let parameters),
                 .season(_, _, let parameters):
                return parameters
            case .search(let query, let parameters):
                var newParameters = parameters
                newParameters.append(query)
                return newParameters
            }
        }
    }
    
}
