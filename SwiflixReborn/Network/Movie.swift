//
//  Movie.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 22/08/21.
//

import Foundation

enum Movie {
    
    case popular(parameters: [RequestParameter])
    case nowPlaying(parameters: [RequestParameter])
    case upcoming(parameters: [RequestParameter])
    
}

// MARK: Computed properties

extension Movie {
    
    // MARK: Path property
    
    var path: String {
        get {
            switch self {
            case .popular(_): return "/movie/popular"
            case .nowPlaying(_): return "/movie/now_playing"
            case .upcoming(_): return "/movie/upcoming"
            }
        }
    }
    
    // MARK: Query items property
    
    var queryItems: [URLQueryItem] {
        get {
            switch self {
            case .popular(let parameters),
                 .nowPlaying(let parameters),
                 .upcoming(let parameters):
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
