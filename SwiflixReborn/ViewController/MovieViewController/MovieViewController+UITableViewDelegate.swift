import UIKit

extension MovieViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? MediaTableViewCell else { return }
        
        self.showMovieDetail(cell.media)
        
    }
    
}

