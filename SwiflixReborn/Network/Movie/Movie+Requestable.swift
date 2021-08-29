extension Movie: Requestable {
    
    var path: String {
        get {
            switch self {
            case .popular(_): return "/movie/popular"
            case .nowPlaying(_): return "/movie/now_playing"
            case .upcoming(_): return "/movie/upcoming"
            case .details(let id, _): return "/movie/\(id.value)"
            case .similar(let id, _): return "/movie/\(id.value)/similar"
            case .reviews(let id, _): return "/movie/\(id.value)/reviews"
            case .videos(let id, _): return "/movie/\(id.value)/videos"
            case .search(_, _): return "/search/movie"
            }
        }
    }
    
    var parameters: [RequestParameter] {
        get {
            switch self {
            case .popular(let parameters),
                 .nowPlaying(let parameters),
                 .upcoming(let parameters),
                 .details(_, let parameters),
                 .similar(_, let parameters),
                 .reviews(_, let parameters),
                 .videos(_, let parameters):
                return parameters
            case .search(let query, let parameters):
                var newParameters = parameters
                newParameters.append(query)
                return newParameters
            }
        }
    }
    
}
