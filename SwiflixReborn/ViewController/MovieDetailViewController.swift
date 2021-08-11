//
//  MovieDetailViewController.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 11/08/21.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var tabSegment: UISegmentedControl!
    @IBOutlet weak var detailTableView: UITableView!
    
    var movieTitle: String?
    var backdrop: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupDetailTableView()
        
        self.navigationItem.title = self.movieTitle
        self.backdropImage.image = self.backdrop
    }
    
    func setupDetailTableView() {
        self.detailTableView.delegate = self
        self.detailTableView.dataSource = self
    }
    
    func setup(with movie: (String?, UIImage?)) {
        self.movieTitle = movie.0
        self.backdrop = movie.1
    }

}

extension MovieDetailViewController: UITableViewDelegate {
    
}

extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
