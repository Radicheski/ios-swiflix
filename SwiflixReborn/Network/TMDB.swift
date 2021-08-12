//
//  TMDB.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 12/08/21.
//

import Foundation

struct TMDB {
    
    static var apiKey: String = ""
    
    static let baseUrl = "https://api.themoviedb.org/3"
    
    static func getTrending(mediaType: MediaType, timeWindow: TimeWindow, onSuccess: ((TrendingResponse) -> Void)?) {

        if let url = URL(string: """
                                 \(Self.baseUrl)/trending/\(mediaType.rawValue)/\(timeWindow)?api_key=\(Self.apiKey)
                                 """) {
            print(url)
            URLSession.shared.dataTask(with: url) { (_data: Data?, _response: URLResponse?, _error: Error?) -> () in
                if let response = _response as? HTTPURLResponse {
                    if response.statusCode == 200,
                       let data = _data {
                        do {
                            let object = try JSONDecoder().decode(TrendingResponse.self, from: data)
                            onSuccess?(object)
                        } catch {
                            print("erro")
                        }
                    } else {

                    }
                }
            }.resume()
        }

    }
    
}




