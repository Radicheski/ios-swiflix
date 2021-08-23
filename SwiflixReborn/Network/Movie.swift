//
//  Movie.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 22/08/21.
//

import Foundation

enum Movie {
    
    case popular(parameters: [RequestParameter] = [])
    case nowPlaying(parameters: [RequestParameter] = [])
    case upcoming(parameters: [RequestParameter] = [])
    case details(id: RequestParameter, parameters: [RequestParameter] = [])
    case similar(id: RequestParameter, parameters: [RequestParameter] = [])
    case reviews(id: RequestParameter, parameters: [RequestParameter] = [])
    case videos(id: RequestParameter, parameters: [RequestParameter] = [])
    
}

// MARK: Computed properties

extension Movie: Requestable {
    
    // MARK: Path property
    
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
            }
        }
    }
    
    // MARK: Parameters property
    
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
            }
        }
    }
    
}
