//
//  SerieController.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 13/08/21.
//

import Foundation

class SerieController {
    
    var trendingPeople = [Media]()
    
    var count: Int {
        get {
            return self.trendingPeople.count
        }
    }

    func loadSerieList(onCompletion: (() -> Void)?) {
        
        let request: TV = .popular()

        TMDB.request(url: request.url) { (response: TMDBResponse<Result>) in
            self.trendingPeople = response.results
            onCompletion?()
        } onError: { error in
            #warning("Handle error")
            print(error)
        }
        
    }
    
    func selectSerie(at indexPath: IndexPath) -> Media {
        
        return self.trendingPeople[indexPath.row]
        
    }

}
