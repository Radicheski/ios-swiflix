enum TV {
    
    case popular(parameters: [RequestParameter] = [])
    case details(id: RequestParameter, parameters: [RequestParameter] = [])
    case similar(id: RequestParameter, parameters: [RequestParameter] = [])
    case reviews(id: RequestParameter, parameters: [RequestParameter] = [])
    case season(id: RequestParameter, season: RequestParameter, parameters: [RequestParameter] = [])
    case search(query: RequestParameter, parameters: [RequestParameter] = [])
    
}
