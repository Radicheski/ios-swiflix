enum Movie {
    
    case popular(parameters: [RequestParameter] = [])
    case nowPlaying(parameters: [RequestParameter] = [])
    case upcoming(parameters: [RequestParameter] = [])
    case details(id: RequestParameter, parameters: [RequestParameter] = [])
    case similar(id: RequestParameter, parameters: [RequestParameter] = [])
    case reviews(id: RequestParameter, parameters: [RequestParameter] = [])
    case videos(id: RequestParameter, parameters: [RequestParameter] = [])
    case search(query: RequestParameter, parameters: [RequestParameter] = [])
    
}
