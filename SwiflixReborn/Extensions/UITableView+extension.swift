import UIKit

extension UITableView {
    
    func register(_ cell: Registrable.Type) {
        self.register(cell.nib, forCellReuseIdentifier: cell.customIdentifier)
    }
    
    func register(_ cells: [Registrable.Type]) {
        cells.forEach { self.register($0) }
    }
    
}
