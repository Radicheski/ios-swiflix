import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var tabSegment: UISegmentedControl!
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var detail: MediaEntity?
    var similar = DetailController<Entity>()
    var reviews = DetailController<Review>()
    var videos = DetailController<Videos>()
    
    var selectedSegment: MovieDetailSegment {
        MovieDetailSegment(rawValue: self.tabSegment.selectedSegmentIndex)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupDetailTableView()
        
        self.navigationItem.title = self.detail?.mediaTitle ?? "(Unknown title)"
        
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
        
        let request: Movie = .details(id: .id(movie.id))
        TMDB.request(request,onSuccess: consumeRequest(response:), onError: presentError(error:))
        
        let requestSimilar: Movie = .similar(id: .id(movie.id))
        self.similar.loadDetails(request: requestSimilar, onError: presentError(error:))
        
        let requestReviews: Movie = .reviews(id: .id(movie.id))
        self.reviews.loadDetails(request: requestReviews, onError: presentError(error:))
        
        let requestVideos: Movie = .videos(id: .id(movie.id))
        self.videos.loadDetails(request: requestVideos, onError: presentError(error:))
        
    }
    
   func presentError(error: Error) {
        let alert: UIAlertController = UIAlertController.buildSimpleInfoAlert(title: "Error", message: error.localizedDescription)
        self.present(alert, animated: true) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    func consumeRequest(response: MediaEntity) {
        self.detail = response
        self.reloadData()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.viewDidLoad()
        }
    }
    
    @IBAction func tabDidSelect(_ sender: UISegmentedControl) {
        self.detailTableView.reloadData()
    }
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        if let detail = self.detail {
            Database.shared.setFavorite(type: "movie", data: detail) {
                self.favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            } onError: { error in
                self.presentError(error: error)
            }
        }
    }
    
}
