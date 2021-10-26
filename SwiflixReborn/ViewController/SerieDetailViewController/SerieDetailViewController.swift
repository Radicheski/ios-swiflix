import UIKit

class SerieDetailViewController: UIViewController {
    
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var tabSegment: UISegmentedControl!
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var detail: SerieEntity?
    var similar = DetailController<Entity>()
    var episodes: [Episode]? = []
    var reviews = DetailController<Review>()
    
    var selectedSegment: SerieDetailSegment {
        SerieDetailSegment(rawValue: self.tabSegment.selectedSegmentIndex)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupDetailTableView()
        
        self.navigationItem.title = self.detail?.mediaTitle ?? "(Unknown title)"
        if let rate = self.detail?.voteAverage {
            self.rateLabel.text = "\(rate)"
        } else {
            self.rateLabel.isHidden = true
        }
        
        TMDB.getImage(size: "w780", string: self.detail?.backdropPath ?? "") { _data in
            if let data = _data,
               let image = UIImage(data: data){
                DispatchQueue.main.async {
                    self.backdropImage.image = image
                }
            }
        }
    }
    
    func setupDetailTableView() {
        let cells: [Registrable.Type] = [PersonBiographyTableViewCell.self, MediaTableViewCell.self, EpisodeTableViewCell.self]
        self.detailTableView.register(cells)
        self.detailTableView.delegate = self
        self.detailTableView.dataSource = self
    }
    
    func setup(with serie: Media) {
        
        let request: TV = .details(id: .id(serie.id))
        TMDB.request(request, onSuccess: consumeRequest(response:), onError: presentError(error:))
        
        let requestSimilar: TV = .similar(id: .id(serie.id))
        self.similar.loadDetails(request: requestSimilar, onError: presentError(error:))
        
        let requestReviews: TV = .reviews(id: .id(serie.id))
        self.reviews.loadDetails(request: requestReviews, onError: presentError(error:))
        
    }
    
    func presentError(error: Error) {
        let alert: UIAlertController = UIAlertController.buildSimpleInfoAlert(title: "Error", message: error.localizedDescription)
        self.present(alert, animated: true) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    func consumeRequest(response: SerieEntity) {
        self.detail = response
        if let seasons = self.detail?.numberOfSeasons, seasons > 0{
            for season in 1...(self.detail?.numberOfSeasons ?? 0) {
                if let serie = self.detail {
                    let requestSeason: TV = .season(id: .id(serie.id), season: .season(season))
                    TMDB.request(requestSeason, onSuccess: loadEpisodes(season:), onError: presentError(error:))
                }
            }
        }
        DispatchQueue.main.async {
            self.viewDidLoad()
        }
    }
    
    func loadEpisodes(season: SerieSeasonResponse) {
        self.episodes?.append(contentsOf: season.episodes)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.detailTableView.reloadData()
        }
    }
    
    @IBAction func segmentDidSelect(_ sender: UISegmentedControl) {
        self.detailTableView.reloadData()
    }
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
    }
    
}
