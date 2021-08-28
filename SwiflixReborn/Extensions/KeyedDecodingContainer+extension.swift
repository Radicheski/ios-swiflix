extension KeyedDecodingContainer {
    
    enum ParsingError: Error {
        case noKeyFound
    }
    
    func decode<T>(_ type: T.Type, forKey keys: K...) throws -> T where T: Decodable {
        try decode(type, forKey: keys)
    }
    
    func decode<T>(_ type: T.Type, forKey keys: [K]) throws -> T where T: Decodable {
        for key in keys {
            if let val = try? self.decode(type, forKey: key) {
                return val
            }
        }
        throw ParsingError.noKeyFound
    }
    
}
