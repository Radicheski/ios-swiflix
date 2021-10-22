protocol DataSource {
    
    associatedtype T
    
    var data: [T] { get }
    var count: Int { get }
    
    func getElement(at position: Int) -> T
    func loadList(request: Requestable, completionHandler: (() -> Void)?, onError: ((Error) -> Void)?)
    
}
