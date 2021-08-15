//
//  NowPlayingController.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 15/08/21.
//

import Foundation

class NowPlayingController {
    
    var trendingPeople = [Media]()
    
    var count: Int {
        get {
            return self.trendingPeople.count
        }
    }

    func loadNowPlayingList(onCompletion: (() -> Void)?) {

        TMDB.getNowPlaying { response in
            self.trendingPeople = response.results
            onCompletion?()
        } onError: { error in
            #warning("Handle error")
            print(error)
        }
        
    }
    
    func selectPerson(at indexPath: IndexPath) -> Media {
        
        return self.trendingPeople[indexPath.row]
        
    }
    
}