//
//  Movie.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 22/08/21.
//

import Foundation

enum TV {
    
    case popular(parameters: [RequestParameter] = [])
    case details(id: RequestParameter, parameters: [RequestParameter] = [])
    case similar(id: RequestParameter, parameters: [RequestParameter] = [])
    case reviews(id: RequestParameter, parameters: [RequestParameter] = [])
    case season(id: RequestParameter, season: RequestParameter, parameters: [RequestParameter] = [])
    
}

// MARK: Computed properties

extension TV: Requestable {
    
    // MARK: Path property
    
    var path: String {
        get {
            switch self {
            case .popular(_): return "/tv/popular"
            case .details(let id, _): return "/tv/\(id.value)"
            case .similar(let id, _): return "/tv/\(id.value)/similar"
            case .reviews(let id, _): return "/tv/\(id.value)/reviews"
            case .season(let id, let season, _): return "/tv/\(id.value)/season/\(season.value)"
            }
        }
    }
    
    // MARK: Parameters property
    
    var parameters: [RequestParameter] {
        get {
            switch self {
            case .popular(let parameters),
                 .details(_, let parameters),
                 .similar(_, let parameters),
                 .reviews(_, let parameters),
                 .season(_, _, let parameters):
                return parameters
            }
        }
    }
    
}
