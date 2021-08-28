import UIKit
import FirebaseAuth

class PersonViewController: UIViewController {

    @IBOutlet weak var personTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var profileButton: UIBarButtonItem!
    
    var controller = ListController<PeopleResult>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupPersonTableView()
        
        self.searchBar.searchTextField.textColor = .gray
        
        let listRequest: People = .popular()
        
        self.controller.loadList(request: listRequest) {
            DispatchQueue.main.async {
                self.personTableView.reloadData()
            }
        }
        
        self.searchBar.delegate = self
        
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
        self.navigationController?.dismiss(animated: true, completion: {
            do {
                try Auth.auth().signOut()
            } catch {
                #warning("Handle this error")
            }
        })
    }

}
