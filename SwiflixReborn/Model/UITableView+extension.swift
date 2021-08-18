//
//  UITableView+extension.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 18/08/21.
//

import UIKit

extension UITableView {
    
    func register<T>(_ cell: T.Type) where T: UITableViewCell, T: Registrable {
        self.register(cell.nib, forCellReuseIdentifier: cell.customIdentifier)
    }
    
}
