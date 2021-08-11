//
//  MovieViewController.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 11/08/21.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupMovieTableView()
    }

    func setupMovieTableView() {
        self.movieTableView.register(UINib(nibName: "MediaTableViewCell", bundle: nil), forCellReuseIdentifier: MediaTableViewCell.customIdentifier)
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
    }
    
    func showMovieDetail(_ movie: (String?, UIImage?)) {
        self.performSegue(withIdentifier: "MovieToDetail", sender: movie)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        default:
            guard let detail = segue.destination as? MovieDetailViewController,
                  let movie = sender as? (String?, UIImage?) else { return }
            detail.setup(with: movie)
        }
    }

}

extension MovieViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MediaTableViewCell else { return }
        self.showMovieDetail((cell.titleLabel.text, cell.posterImage.image))
    }
    
}

extension MovieViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.customIdentifier) as? MediaTableViewCell else { return UITableViewCell() }
        cell.setupWith(title: "Filme exemplo", poster: UIImage(systemName: "film"))
        return cell
    }
    
}
