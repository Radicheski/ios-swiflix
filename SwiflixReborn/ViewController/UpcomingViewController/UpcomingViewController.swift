import UIKit
import FirebaseAuth

class UpcomingViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var profileButton: UIBarButtonItem!
    
    var controller = ListController<Entity>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupMovieTableView()
        
        let listRequest: Movie = .upcoming()
        
        self.controller.loadList(request: listRequest) {
            DispatchQueue.main.async {
                self.movieTableView.reloadData()
            }
        }
        
        self.setupSearchController()
        
    }
    
    func setupSearchController() {
        
        let searchController = MovieSearchController()
        self.navigationItem.searchController = UISearchController(searchResultsController: searchController)
        self.navigationItem.searchController?.delegate = searchController
        self.navigationItem.searchController?.searchBar.delegate = searchController
        
    }
    
    func setupMovieTableView() {

        self.movieTableView.register(MediaTableViewCell.self)
        
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
    }
    
    func showMovieDetail(_ movie: Media?) {
        self.performSegue(withIdentifier: "ComingToDetail", sender: movie)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        default:
            guard let detail = segue.destination as? MovieDetailViewController,
                  let movie = sender as? Media else { return }
            detail.setup(with: movie)
        }
    }
    
    @IBAction func profileButtonnClicked(_ sender: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true, completion: {
            do {
                try Auth.auth().signOut()
            } catch {
                #warning("Handle this error")
            }
        })
    }

}
