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
    
    var media: Media?
    var detail: MovieDetailResponse?
    var similar: [Media]?
    var reviews: [Review]?
    var videos: [Videos]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupDetailTableView()
        
        self.navigationItem.title = self.media?.mediaTitle ?? "(Unknown title)"
        
        TMDB.getImage(size: "w780", string: self.detail?.backdropPath ?? "") { _data in
            if let data = _data,
               let image = UIImage(data: data){
                DispatchQueue.main.async {
                    self.backdropImage.image = image
                }
            }
        }
        
        self.rateLabel.text = "\(self.detail?.voteAverage ?? 0.0)"
        
    }
    
    func setupDetailTableView() {
        
        let cells: [Registrable.Type] = [PersonBiographyTableViewCell.self, MediaTableViewCell.self]
        self.detailTableView.register(cells)
        
        self.detailTableView.delegate = self
        self.detailTableView.dataSource = self
    }
    
    func setup(with movie: Media) {
        self.media = movie
        let request: Movie = .details(id: .id(movie.id))
        TMDB.request(request) { (response: MovieDetailResponse) in
            self.detail = response
            DispatchQueue.main.async {
                self.viewDidLoad()
            }
        } onError: { error in
            #warning("Handle this error")
        }
        let requestSimilar: Movie = .similar(id: .id(movie.id))
        TMDB.request(requestSimilar) { (response: TMDBResponse<Result>) in
            self.similar = response.results
        } onError: { error in
            #warning("Handle this error")
        }
        let requestReviews: Movie = .reviews(id: .id(movie.id))
        TMDB.request(requestReviews) { (response: TMDBResponse<Review>) in
            self.reviews = response.results
        } onError: { error in
            #warning("Handle this error")
        }
        let requestVideos: Movie = .videos(id: .id(movie.id))
        TMDB.request(requestVideos) { (response: TMDBResponse<Videos>) in
            self.videos = response.results
        } onError: { error in
            #warning("Handle this error")
        }


    }
    
    @IBAction func tabDidSelect(_ sender: UISegmentedControl) {
        self.detailTableView.reloadData()
    }
    
}
