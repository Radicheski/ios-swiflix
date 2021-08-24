extension Result: Person {
    
    var name: String {
        self._name ?? "(No name)"
    }
    
    var profile: String {
        self.profilePath ?? ""
    }
    
}
