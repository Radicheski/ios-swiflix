import UIKit

class PersonSearchController: UITableViewController {
    
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

extension PersonSearchController: UISearchControllerDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let key = searchBar.text {
           let request: People = .search(query: .query(key))
            TMDB.request(request) { (response: TMDBResponse<Entity>) in
                self.results = response.results
                self.reloadData()
            } onError: { error in
                #warning("Handle this error")
            }
        }
    }
    
}

extension PersonSearchController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.results = []
        self.reloadData()
    }
    
}
