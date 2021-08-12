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
    
    static var urlSession: URLSession {
        get {
            return URLSession.shared
        }
    }
    
    static func getTrending(mediaType: MediaType, timeWindow: TimeWindow,
                            onSuccess: ((TrendingResponse) -> Void)?, onError: ((Error) -> Void)?) {
        
        let stringUrl = "\(Self.baseUrl)/trending/\(mediaType.rawValue)/\(timeWindow)?api_key=\(Self.apiKey)"
        
        if let url = URL(string: stringUrl) {
            
            let dataTask = Self.urlSession.dataTask(with: url) { _data, _response, _error in
                
                if let error = _error {
                    onError?(error)
                }
                
                if let response = _response as? HTTPURLResponse {
                    if response.statusCode == 200,
                       let data = _data {
                        do {
                            let object = try JSONDecoder().decode(TrendingResponse.self, from: data)
                            onSuccess?(object)
                        } catch {
                            print(error)
                        }
                    }
                }
                
            }
            
            dataTask.resume()
        }
        
    }
    
    static func getImage(string path: String, onCompletion: @escaping (Data?) -> Void)  {
        
        let stringUrl = "https://image.tmdb.org/t/p/w92/\(path)"
        if let url = URL(string: stringUrl) {
            let request = URLRequest(url: url)
            
            if let cache = URLCache.shared.cachedResponse(for: request) {
                onCompletion(cache.data)
            } else {
                
                let dataTask = Self.urlSession.dataTask(with: request) { _data, _response, _error in
                    if let data = _data,
                       let response = _response {
                        let cacheResponse = CachedURLResponse(response: response, data: data)
                        URLCache.shared.storeCachedResponse(cacheResponse, for: request)
                        onCompletion(data)
                    }
                }
                dataTask.resume()
            }
        }
        
    }
    
}




