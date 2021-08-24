extension Profile: Media {
    //TODO Delete this extension
    
    var id: Int {
        return -1
    }
    
    var mediaTitle: String {
        return ""
    }
    
    var poster: String {
        self.filePath
    }
    

}
