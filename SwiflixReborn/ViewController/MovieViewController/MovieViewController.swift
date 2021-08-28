import UIKit
import FirebaseAuth

class MovieViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var profileButtton: UIBarButtonItem!
    
    var controller = ListController<Result>()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setupMovieTableView()
        
        self.searchBar.searchTextField.textColor = .gray
        
        let listRequest: Movie = .popular()
        
        self.controller.loadList(request: listRequest) {
            DispatchQueue.main.async {
                self.movieTableView.reloadData()
            }
        }
        
        self.searchBar.delegate = self
        
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
