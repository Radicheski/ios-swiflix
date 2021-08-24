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
