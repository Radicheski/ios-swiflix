import UIKit

class SerieViewController: UIViewController {

    @IBOutlet weak var serieTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var controller = ListController<Result>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSerieTableView()
        
        self.searchBar.searchTextField.textColor = .gray
        
        let listRequest: TV = .popular()
        
        self.controller.loadList(request: listRequest) {
            DispatchQueue.main.async {
                self.serieTableView.reloadData()
            }
        }

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

}
