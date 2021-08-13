//
//  SerieController.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 13/08/21.
//

import Foundation

class SerieController {
    
    var trendingSeries = [Media]()
    
    var count: Int {
        get {
            return self.trendingSeries.count
        }
    }

    func loadSerieList(onCompletion: (() -> Void)?) {

        TMDB.getTrending(mediaType: .tv, timeWindow: .day) { response in
            self.trendingSeries = response.results
            onCompletion?()
        } onError: { error in
            #warning("Handle error")
            print(error)
        }
        
    }
    
    func selectSerie(at indexPath: IndexPath) -> Media {
        
        return self.trendingSeries[indexPath.row]
        
    }

}
