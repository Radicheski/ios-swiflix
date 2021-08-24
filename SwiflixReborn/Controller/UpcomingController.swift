//
//  UpcomingController.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 15/08/21.
//

import Foundation

import Foundation

class UpcomingController {
    
    var upcoming = [Media]()
    
    var count: Int {
        get {
            return self.upcoming.count
        }
    }
    
    func loadUpcomingList(onCompletion: (() -> Void)?) {
        
        let request: Movie = .upcoming()
        
        TMDB.request(url: request.url) { (response: TMDBResponse<UpcomingResult>) in
            self.upcoming = response.results
            onCompletion?()
        } onError: { error in
            #warning("Handle error")
            print(error)
        }
        
    }
    
    func selectUpcomingMovie(at indexPath: IndexPath) -> Media {
        
        return self.upcoming[indexPath.row]
        
    }
    
}
