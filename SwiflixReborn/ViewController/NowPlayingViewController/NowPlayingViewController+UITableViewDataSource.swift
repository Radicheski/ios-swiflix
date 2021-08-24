import UIKit

extension NowPlayingViewController: UITableViewDataSource {
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
