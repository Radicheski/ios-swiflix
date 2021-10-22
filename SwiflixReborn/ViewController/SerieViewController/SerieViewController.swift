import UIKit
import FirebaseAuth

class SerieViewController: UIViewController {

    @IBOutlet weak var serieTableView: UITableView!
    @IBOutlet weak var profileButton: UIBarButtonItem!
    
    var controller = ListController<Entity>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSerieTableView()
        
        let listRequest: TV = .popular()
        
        self.controller.loadList(request: listRequest, completionHandler: responseConsumer, onError: presentError(error:))
        
        self.setupSearchController()
        
    }
    
    func responseConsumer() {
        DispatchQueue.main.async {
            self.serieTableView.reloadData()
        }
    }
    
    func presentError(error: Error) {
        let alert: UIAlertController = UIAlertController.buildSimpleInfoAlert(title: "Error", message: error.localizedDescription)
        self.present(alert, animated: true) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    func setupSearchController() {
        
        let searchController = SerieSearchController()
        self.navigationItem.searchController = UISearchController(searchResultsController: searchController)
        self.navigationItem.searchController?.delegate = searchController
        self.navigationItem.searchController?.searchBar.delegate = searchController

    }
    
    func setupSerieTableView() {
        
        self.serieTableView.register(MediaTableViewCell.self)
        
        self.serieTableView.delegate = self
        self.serieTableView.dataSource = self
    }
    
    func showSerieDetails(_ serie: Media?) {
        self.performSegue(withIdentifier: "SeriesToDetail", sender: serie)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        default:
            guard let detail = segue.destination as? SerieDetailViewController,
                  let serie = sender as? Media else { return }
            detail.setup(with: serie)
        }
    }
    
    @IBAction func profileButtonnClicked(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "ToProfile", sender: nil)
    }

}
