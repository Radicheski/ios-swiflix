import UIKit

extension Registrable {
    
    static var customIdentifier: String { String(describing: Self.self) }
    static var nib: UINib { UINib(nibName: Self.customIdentifier, bundle: nil) }
    
}
