//
//  Movie.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 22/08/21.
//

import Foundation

enum TV {
    
    case popular(parameters: [RequestParameter])
    case details(id: RequestParameter, parameters: [RequestParameter])
    case similar(id: RequestParameter, parameters: [RequestParameter])
    case reviews(id: RequestParameter, parameters: [RequestParameter])
    
}

// MARK: Computed properties

extension TV {
    
    // MARK: Path property
    
    var path: String {
        get {
            switch self {
            case .popular(_): return "/tv/popular"
            case .details(let id, _): return "/tv/\(id.value)"
            case .similar(let id, _): return "/tv/\(id.value)/similar"
            case .reviews(let id, _): return "/tv/\(id.value)/reviews"
            }
        }
    }
    
    // MARK: Query items property
    
    var queryItems: [URLQueryItem] {
        get {
            switch self {
            case .popular(let parameters),
                 .details(_, let parameters),
                 .similar(_, let parameters),
                 .reviews(_, let parameters):
                return parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            }
        }
    }
    
    // MARK: URL property
    
    var url: URL? {
        get {
            var components = URLComponents(string: TMDB.baseUrl)
            components?.path.append(self.path)
            components?.queryItems = self.queryItems
            return components?.url
        }
    }
    
}
