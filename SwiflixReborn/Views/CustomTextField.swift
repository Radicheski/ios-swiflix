import UIKit

class CustomTextField: UITextField {
    
    @IBInspectable var placeholderColor: UIColor? {
        didSet {
            if let string = self.placeholder,
               let color = self.placeholderColor {
                self.attributedPlaceholder = NSAttributedString(string: string, attributes: [NSAttributedString.Key.foregroundColor: color])
            }
        }
    }
    
}
