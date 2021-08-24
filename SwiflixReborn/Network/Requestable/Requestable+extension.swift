import Foundation

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
