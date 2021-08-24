import UIKit

protocol Registrable where Self: UITableViewCell {
    
    static var customIdentifier: String { get }
    static var nib: UINib { get }
    
}
