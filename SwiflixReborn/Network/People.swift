//
//  Movie.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 22/08/21.
//

import Foundation

enum People {
    
    case popular(parameters: [RequestParameter])
    
}

// MARK: Computed properties

extension People {
    
    // MARK: Path property
    
    var path: String {
        get {
            switch self {
            case .popular(_): return "/person/popular"
            }
        }
    }
    
    // MARK: Query items property
    
    var queryItems: [URLQueryItem] {
        get {
            switch self {
            case .popular(let parameters):
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
