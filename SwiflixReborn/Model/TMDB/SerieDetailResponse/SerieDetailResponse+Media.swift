extension SerieDetailResponse: Media {
    
    var mediaTitle: String {
        self.name
    }
    
    var poster: String {
        self.posterPath
    }
    
}
