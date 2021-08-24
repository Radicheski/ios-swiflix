//
//  MovieViewController.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 11/08/21.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!

    var controller = ListController<Result>()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setupMovieTableView()
        
        let listRequest: Movie = .popular()
        
        self.controller.loadList(request: listRequest) {
            DispatchQueue.main.async {
                self.movieTableView.reloadData()
            }
        }
        
    }

    func setupMovieTableView() {
        
        self.movieTableView.register(MediaTableViewCell.self)
        
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
        
    }
    
    func showMovieDetail(_ movie: Media?) {
        
        self.performSegue(withIdentifier: "MovieToDetail", sender: movie)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        
        default:
            
            guard let detail = segue.destination as? MovieDetailViewController,
                  let movie = sender as? Media else { return }
            detail.setup(with: movie)
            
        }
        
    }

}

extension MovieViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? MediaTableViewCell else { return }
        
        self.showMovieDetail(cell.media)
        
    }
    
}

extension MovieViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.controller.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.customIdentifier) as? MediaTableViewCell else { return UITableViewCell() }
        
        let media = self.controller.getElement(at: indexPath.row)
        
        cell.setupWith(media: media)
        return cell
    }
    
}
