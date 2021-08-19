//
//  Registrable.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 18/08/21.
//

import UIKit

protocol Registrable where Self: UITableViewCell {
    
    static var customIdentifier: String { get }
    static var nib: UINib { get }
    
}
