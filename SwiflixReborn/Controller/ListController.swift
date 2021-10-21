class ListController<T>: DataSource where T: Codable {
    
    var data = [T]()
    
    func getElement(at position: Int) -> T {
        return self.data[position]
    }
    
    var count: Int {
        get { self.data.count }
    }
    
    func loadList(request: Requestable, completionHandler: (() -> Void)?, onError: (() -> Void)?) {

        TMDB.request(request) { (response: TMDBResponse<T>) in
            self.data = response.results
            completionHandler?()
        } onError: { error in
            onError?()
        }
        
    }
    
}
