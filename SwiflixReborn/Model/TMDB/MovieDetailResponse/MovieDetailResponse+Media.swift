extension MovieDetailResponse: Media {
    
    var mediaTitle: String {
        self.title
    }
    
    var poster: String {
        self.backdropPath ?? self.posterPath ?? ""
    }
    
}
