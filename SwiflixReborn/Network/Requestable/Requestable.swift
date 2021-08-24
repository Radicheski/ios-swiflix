import Foundation

protocol Requestable {
    
    var path: String { get }
    var parameters: [RequestParameter] { get }
    var queryItems: [URLQueryItem] { get }
    var url: URL? { get }
    
}
