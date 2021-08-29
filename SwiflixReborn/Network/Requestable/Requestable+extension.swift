import Foundation

extension Requestable {
    
    var queryItems: [URLQueryItem] {
        get {
            self.parameters.map( { $0.queryItem } )
        }
    }
    
}
