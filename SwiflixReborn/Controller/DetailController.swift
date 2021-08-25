class DetailController<T> where T: Codable {
    
    var data = [T]()
    
    var count: Int {
        get {
            self.data.count
        }
    }
    
    private(set) var lastPageLoaded: Int = 0
    
    func loadDetails(request: Requestable, completionHandler: (() -> Void)? = nil) {
        TMDB.request(request) { (response: TMDBResponse<T>) in
            self.data = response.results
            if let page = response.page {
                self.lastPageLoaded = page
            }
            completionHandler?()
        } onError: { error in
            #warning("Handle this error")
        }
    }
    
    func getElement(at index: Int) -> T {
        return self.data[index]
    }
    
}
