//
//  ListController.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 24/08/21.
//

import Foundation

class ListController<T>: DataSource where T: Codable {
    
    var data = [T]()
    
    func getElement(at position: Int) -> T {
        return self.data[position]
    }
    
    var count: Int {
        get { self.data.count }
    }
    
    func loadList(request: Requestable, completionHandler: (() -> Void)?) {

        TMDB.request(request) { (response: TMDBResponse<T>) in
            self.data = response.results
            completionHandler?()
        } onError: { error in
            #warning("Handle error")
            print(error)
        }
        
    }
    
}

protocol DataSource {
    
    associatedtype T
    
    var data: [T] { get }
    var count: Int { get }
    
    func getElement(at position: Int) -> T
    func loadList(request: Requestable, completionHandler: (() -> Void)?)
    
}

extension DataSource {
    
    func loadList(request: Requestable, completionHandler: (() -> Void)?) {
        print("Method not implemented")
    }
    
}
