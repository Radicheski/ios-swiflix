import Foundation

struct TMDB {
    
    static let baseUrl = "https://api.themoviedb.org/3"
    
    static var apiKey: RequestParameter = .apiKey("")
    
    static var defaultLanguage: RequestParameter = .language(.pt, .BR)
    
    static var urlSession: URLSession {
        get {
            return URLSession.shared
        }
    }
    
    static func setApiKey(plist: String, plistKey: String) {
        if let path = Bundle.main.path(forResource: plist, ofType: "plist"),
           let keys = NSDictionary(contentsOfFile: path),
           let key = keys.value(forKey: plistKey) as? String {
            TMDB.apiKey = .apiKey(key)
        }
    }
    
    static func request<T: Codable>(_ request: Requestable, onSuccess: ((T) -> Void)?, onError: ((Error) -> Void)?) {
        
        var url = URLComponents(string: Self.baseUrl)
        
        url?.path.append(request.path)
        
        url?.queryItems = request.queryItems
        
        if let items = url?.queryItems {
           if !items.contains(where: { $0.name ==  "api_key" }) {
                let key = URLQueryItem(name: Self.apiKey.key, value: Self.apiKey.value)
                url?.queryItems?.append(key)
           }
            
            if !items.contains(where: { $0.name ==  "language" }) {
                 let key = URLQueryItem(name: Self.defaultLanguage.key, value: Self.defaultLanguage.value)
                 url?.queryItems?.append(key)
            }
        }
        
        if let url = url?.url {
            
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
    
}
