extension Result: Media {

    var mediaTitle: String {
        self.title ?? self._name ?? "(No title)"
    }

    var poster: String {
        self.posterPath ?? ""
    }
    
}
