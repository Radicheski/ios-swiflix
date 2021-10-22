import UIKit
import FirebaseAuth

class PersonViewController: UIViewController {

    @IBOutlet weak var personTableView: UITableView!
    @IBOutlet weak var profileButton: UIBarButtonItem!
    
    var controller = ListController<Entity>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupPersonTableView()
        
        let listRequest: People = .popular()
        
        self.controller.loadList(request: listRequest, completionHandler: responseConsumer, onError: presentError(error:))
        
        self.setupSearchController()
        
    }
    
    func responseConsumer() {
        DispatchQueue.main.async {
            self.personTableView.reloadData()
        }
    }
    
    func presentError(error: Error) {
        let alert: UIAlertController = UIAlertController.buildSimpleInfoAlert(title: "Error", message: error.localizedDescription)
        self.present(alert, animated: true) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    func setupSearchController() {
        
        let searchController = PersonSearchController()
        self.navigationItem.searchController = UISearchController(searchResultsController: searchController)
        self.navigationItem.searchController?.delegate = searchController
        self.navigationItem.searchController?.searchBar.delegate = searchController
        
    }
    
    func setupPersonTableView() {

        self.personTableView.register(PersonTableViewCell.self)
        
        self.personTableView.delegate = self
        self.personTableView.dataSource = self
    }

    func showDetail(_ person: Person?) {
        self.performSegue(withIdentifier: "PeopleToDetail", sender: person)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        default:
            guard let detail = segue.destination as? PersonDetailViewController,
                  let person = sender as? Person else { return }
            detail.setup(with: person)
        }
    }
    
    @IBAction func profileButtonnClicked(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "ToProfile", sender: nil)
    }

}
