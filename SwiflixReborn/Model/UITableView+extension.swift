//
//  UITableView+extension.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 18/08/21.
//

import UIKit

extension UITableView {
    
    func register(_ cell: Registrable.Type) {
        self.register(cell.nib, forCellReuseIdentifier: cell.customIdentifier)
    }
    
    func register(_ cells: [Registrable.Type]) {
        cells.forEach { self.register($0) }
    }
    
}
