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
    
    static var defaultLanguage: String = "pt-BR"
    
    static var newApiKey: RequestParameter {
        get {
            .apiKey(Self.apiKey)
        }
    }
    static var newDefaultLanguage: RequestParameter = .language(.en, .US)
    
    static var urlSession: URLSession {
        get {
            return URLSession.shared
        }
    }
    
    static func setApiKey(plist: String, plistKey: String) {
        if let path = Bundle.main.path(forResource: plist, ofType: "plist"),
           let keys = NSDictionary(contentsOfFile: path),
           let key = keys.value(forKey: plistKey) as? String {
            TMDB.apiKey = key
        }
    }
    
    static func request<T: Codable>(string: String, onSuccess: ((T) -> Void)?, onError: ((Error) -> Void)?) {
        
        let stringUrl: String
        if string.contains("?") {
            stringUrl = "\(Self.baseUrl)\(string)&api_key=\(Self.apiKey)"
        } else {
            stringUrl = "\(Self.baseUrl)\(string)?api_key=\(Self.apiKey)"
        }
        
        if let url = URL(string: stringUrl) {
            
            Self.request(url: url) { result in
                onSuccess?(result)
            } onError: { error in
                onError?(error)
            }

        }
        
    }
    
    static func request<T: Codable>(url: URL?, onSuccess: ((T) -> Void)?, onError: ((Error) -> Void)?) {
        
        if let url = url {
            
            let dataTask = Self.urlSession.dataTask(with: url) { _data, _response, _error in
                
                if let error = _error {
                    onError?(error)
                }
                
                if let response = _response as? HTTPURLResponse {
                    if response.statusCode == 200,
                       let data = _data {
                        do {
                            let object = try JSONDecoder().decode(T.self, from: data)
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
        
        Self.getImage(size: "w92", string: path) { data in
            onCompletion(data)
        }
        
    }
    
    static func getImage(size: String, string path: String, onCompletion: @escaping (Data?) -> Void)  {
        
        let stringUrl = "https://image.tmdb.org/t/p/\(size)/\(path)"
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
    
//    static func getMovieSimilar(id: Int, language: String = Self.defaultLanguage,
//                                onSuccess: ((TrendingResponse) -> Void)?, onError: ((Error) -> Void)?) {
//        
//        let urlString = "/movie/\(id)/similar?language=\(language)"
//        TMDB.request(string: urlString) { credits in
//            onSuccess?(credits)
//        } onError: { error in
//            onError?(error)
//        }
//        
//    }
    
    static func getMovieReviews(id: Int, language: String = Self.defaultLanguage,
                                onSuccess: ((MovieReviewResponse) -> Void)?, onError: ((Error) -> Void)?) {
        
        let urlString = "/movie/\(id)/reviews?language=\(language)"
        TMDB.request(string: urlString) { credits in
            onSuccess?(credits)
        } onError: { error in
            onError?(error)
        }
        
    }
    
}




