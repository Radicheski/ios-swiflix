import UIKit

class SerieSearchController: UITableViewController {
    
    var results: [Entity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(MediaTableViewCell.self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.customIdentifier) as? MediaTableViewCell else { return UITableViewCell() }
        let media = self.results[indexPath.row]
        cell.setupWith(media: media)
        return cell
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension SerieSearchController: UISearchControllerDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let key = searchBar.text {
           let request: TV = .search(query: .query(key))
            TMDB.request(request, onSuccess: responseConsumer(response:), onError: presentError(error:))
        }
    }
    
    func responseConsumer(response: TMDBResponse<Entity>) {
        self.results = response.results
        self.reloadData()
    }
    
    func presentError(error: Error) {
        let alert: UIAlertController = UIAlertController.buildSimpleInfoAlert(title: "Error", message: error.localizedDescription)
        self.present(alert, animated: true) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension SerieSearchController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.results = []
        self.reloadData()
    }
    
}
