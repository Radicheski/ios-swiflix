//
//  Requestable.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 22/08/21.
//

import Foundation

protocol Requestable {
    
    var path: String { get }
    var parameters: [RequestParameter] { get }
    var queryItems: [URLQueryItem] { get }
    var url: URL? { get }
    
}

extension Requestable {
    
    var queryItems: [URLQueryItem] {
        get {
            self.parameters.map( { $0.queryItem } )
        }
    }
    
    var url: URL? {
        get {
            var components = URLComponents(string: TMDB.baseUrl)
            components?.path.append(self.path)
            components?.queryItems = self.queryItems
            if let items = components?.queryItems,
               !items.contains(where: { $0.name ==  "api_key" }) {
                let key = URLQueryItem(name: TMDB.apiKey.key, value: TMDB.apiKey.value)
                components?.queryItems?.append(key)
            }
            return components?.url
        }
    }
    
}
