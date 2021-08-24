import Foundation

extension RequestParameter {
    
    var value: String {
        get {
            switch self {
            case .apiKey(let value): return value
            case .language(let language, let region): return "\(language)-\(region)"
            case .id(let id): return id.description
            case .page(let page): return page.description
            case .region(let region): return region.rawValue
            case .appendToResponse(let string): return string
            case .season(let season): return season.description
            case .query(let query): return query
            }
        }
    }

    var key: String {
        get {
            switch self {
            case .apiKey(_): return "api_key"
            case .language(_, _): return "language"
            case .id(_): return "id"
            case .page(_): return "page"
            case .region(_): return "region"
            case .appendToResponse(_): return "append_to_response"
            case .season(_): return "season"
            case .query(_): return "query"
            }
        }
    }
    
    var queryItem: URLQueryItem {
        get {
            URLQueryItem.init(name: self.key, value: self.value)
        }
    }
    
}
