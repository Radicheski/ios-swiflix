enum People {
    
    case popular(parameters: [RequestParameter] = [])
    case details(id: RequestParameter, parameters: [RequestParameter] = [])
    case combineCredits(id: RequestParameter, parameters: [RequestParameter] = [])
    case images(id: RequestParameter, parameters: [RequestParameter] = [])
    case search(query: RequestParameter, parameters: [RequestParameter] = [])
    
}
