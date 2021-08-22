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
        let request: Movie = .details(id: .id(movie.id), parameters: [.apiKey(TMDB.apiKey)])
        TMDB.request(url: request.url) { (response: MovieDetailResponse) in
            self.detail = response
            DispatchQueue.main.async {
                self.viewDidLoad()
            }
        } onError: { error in
            #warning("Handle this error")
        }
        let requestSimilar: Movie = .similar(id: .id(movie.id), parameters: [TMDB.newApiKey])
        TMDB.request(url: requestSimilar.url) { (response: TrendingResponse) in
            self.similar = response.results
        } onError: { error in
            #warning("Handle this error")
        }
        TMDB.getMovieReviews(id: movie.id) { response in
            self.reviews = response.results
        } onError: { error in
            #warning("Handle this error")
        }

    }
    
    @IBAction func tabDidSelect(_ sender: UISegmentedControl) {
        self.detailTableView.reloadData()
    }
    
}

extension MovieDetailViewController: UITableViewDelegate {
    
}

extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.tabSegment.selectedSegmentIndex {
        case 0:
            return 1
        case 1:
            return self.similar?.count ?? 0
        case 3:
            return self.reviews?.count ?? 0
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch self.tabSegment.selectedSegmentIndex {
        case 0:
            return 3
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch self.tabSegment.selectedSegmentIndex {
        case 0:
            
            switch section {
            case MovieGeneralSection.overview.rawValue: return "Overview"
            case MovieGeneralSection.originalTitle.rawValue: return "Original title"
            case MovieGeneralSection.releaseDate.rawValue: return "Release date"
            default: return nil
            }
            
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.tabSegment.selectedSegmentIndex {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonBiographyTableViewCell.customIdentifier) as? PersonBiographyTableViewCell else { return UITableViewCell() }
            return self.getGeneralIInformation(cell, at: indexPath)
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.customIdentifier) as? MediaTableViewCell,
                  let media = self.similar?[indexPath.row] else { return UITableViewCell() }
            cell.setupWith(media: media)
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonBiographyTableViewCell.customIdentifier) as? PersonBiographyTableViewCell,
                  let review = self.reviews?[indexPath.row] else { return UITableViewCell() }
            cell.setup(with: review.content)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func getGeneralIInformation(_ cell: PersonBiographyTableViewCell, at indexPath: IndexPath) -> PersonBiographyTableViewCell{
        
        switch indexPath.section {
        case MovieGeneralSection.overview.rawValue:
            cell.setup(with: self.detail?.overview ?? "No overview available")
        case MovieGeneralSection.originalTitle.rawValue:
            cell.setup(with: self.detail?.originalTitle ?? "No orginal title avilable")
        case MovieGeneralSection.releaseDate.rawValue:
            cell.setup(with: self.detail?.releaseDate ?? "No release date available")
        default:
            cell.setup(with: "")
        }
        
        return cell
    }
    
}

enum MovieGeneralSection: Int {
    
    case overview = 0
    case originalTitle = 1
    case releaseDate = 2
    
}
