import UIKit

extension UIAlertController {
    
    static func buildSimpleInfoAlert(title: String? = nil, message: String? = nil, completionHandler: (() -> Void)? = nil) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let button = UIAlertAction(title: "OK", style: .default) { _ in
            completionHandler?()
        }
        
        alert.addAction(button)
        
        return alert
        
    }
    
}
