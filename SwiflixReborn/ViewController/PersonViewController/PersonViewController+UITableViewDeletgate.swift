import UIKit

extension PersonViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? PersonTableViewCell else { return }
        self.showDetail(cell.person)
    }
    
}
