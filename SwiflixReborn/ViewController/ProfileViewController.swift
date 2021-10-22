import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var selectorSegment: UISegmentedControl!
    @IBOutlet weak var exitButton: UIBarButtonItem!
    
    var segmentSelected: Segment {
        get {
            return Segment(rawValue: self.selectorSegment.selectedSegmentIndex) ?? Segment.movie
        }
    }
    
    var controller = ListController<Entity>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(MediaTableViewCell.self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    @IBAction func exitButtonAction(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch {
            self.presentError(error: error)
        }
    }
    
    func presentError(error: Error) {
        let alert: UIAlertController = UIAlertController.buildSimpleInfoAlert(title: "Error", message: error.localizedDescription)
        self.present(alert, animated: true) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func segmentDidSelect(_ sender: UISegmentedControl) {
        switch self.segmentSelected {
        case .movie:
            let request: Movie = .popular()
            self.controller.loadList(request: request, completionHandler: self.relaodData, onError: presentError(error:))
        case .tv:
            let request: TV = .popular()
            self.controller.loadList(request: request, completionHandler: self.relaodData, onError: presentError(error:))
        case .person:
            let request: People = .popular()
            self.controller.loadList(request: request, completionHandler: self.relaodData, onError: presentError(error:))
        }
    }
    
    func relaodData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    enum Segment: Int {
        case movie = 0
        case tv = 1
        case person = 2
    }
    
}

extension ProfileViewController: UITableViewDelegate {
    
}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.customIdentifier) as? MediaTableViewCell else { return UITableViewCell() }
        let media = self.controller.getElement(at: indexPath.row)
        cell.setupWith(media: media)
        return cell
    }

}
