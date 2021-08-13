//
// Created by Erik Radicheski da Silva on 12/08/21.
//

import Foundation

class MovieController {
    
    var trendingMovies = [Media]()
    
    var count: Int {
        get {
            return self.trendingMovies.count
        }
    }

    func loadMovieList(onCompletion: (() -> Void)?) {

        TMDB.getTrending(mediaType: .movie, timeWindow: .day) { response in
            self.trendingMovies = response.results
            onCompletion?()
        } onError: { error in
            #warning("Handle error")
            print(error)
        }
        
    }
    
    func selectMovie(at indexPath: IndexPath) -> Media {
        
        return self.trendingMovies[indexPath.row]
        
    }

}
