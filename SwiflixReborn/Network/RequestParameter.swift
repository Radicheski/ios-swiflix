//
//  RequestParameter.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 22/08/21.
//

import Foundation

enum RequestParameter {
    
    case apiKey(String)
    case id(Int)
    case language(Language, Region)
    case page(Int)
    case region(Region)
    case appendToResponse(String)
    case season(Int)
    case query(String)
    
}

// MARK: Computed properties

extension RequestParameter {
    
    // MARK: Value property
    
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
    
    // MARK: Key property

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
