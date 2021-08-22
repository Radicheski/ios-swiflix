//
//  Movie.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 22/08/21.
//

import Foundation

enum People {
    
    case popular(parameters: [RequestParameter])
    case details(id: RequestParameter, parameters: [RequestParameter])
    case combineCredits(id: RequestParameter, parameters: [RequestParameter])
    
}

// MARK: Computed properties

extension People: Requestable {
    
    // MARK: Path property
    
    var path: String {
        get {
            switch self {
            case .popular(_): return "/person/popular"
            case .details(let id, _): return "/person/\(id.value)"
            case .combineCredits(let id, _): return "/person/\(id.value)/combined_credits"
            }
        }
    }
    
    // MARK: Query items property
    
    var queryItems: [URLQueryItem] {
        get {
            switch self {
            case .popular(let parameters),
                 .details(_, let parameters),
                 .combineCredits(_, let parameters):
                return parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            }
        }
    }
    
}
