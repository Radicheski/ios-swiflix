import UIKit

extension PersonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.customIdentifier) as? PersonTableViewCell else { return UITableViewCell() }
        
        let person = self.controller.getElement(at: indexPath.row)
        cell.setupWith(person: person)
        return cell
        
    }
    
    
}
