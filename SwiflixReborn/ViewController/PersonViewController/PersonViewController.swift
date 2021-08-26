import UIKit

class PersonViewController: UIViewController {

    @IBOutlet weak var personTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
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

}
