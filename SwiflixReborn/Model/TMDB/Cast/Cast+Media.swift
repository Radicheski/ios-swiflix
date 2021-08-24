extension Cast: Media {
    
    var mediaTitle: String {
        self.title ?? self.name ?? "(Unknown name)"
    }
    
    var poster: String {
        self.posterPath ?? self.backdropPath ?? ""
    }
    
}
