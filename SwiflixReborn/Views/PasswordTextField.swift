import UIKit

class PasswordTextField: CustomTextField {
    
    override var isSecureTextEntry: Bool {
        didSet {
            if (self.isSecureTextEntry) {
                self.hiddenButton?.setImage(UIImage(systemName: "eye"), for: .normal)
            } else {
                self.hiddenButton?.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            }
        }
    }
    
    override var placeholderColor: UIColor? {
        didSet {
            if let color = self.placeholderColor {
                self.hiddenButton?.tintColor = color
            }
        }
    }
    
    var hiddenButton: UIButton?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.isSecureTextEntry = true
        
        let buttonFrame = CGRect(x: self.frame.size.width - self.frame.size.height,
                                 y: 0,
                                 width: self.frame.size.width,
                                 height: self.frame.size.height)
        let hiddenButton = UIButton(frame: buttonFrame)
        hiddenButton.setImage(UIImage(systemName: "eye"), for: .normal)
        hiddenButton.addTarget(self, action: #selector(self.setIsSecureEntry), for: .touchUpInside)
        
        self.hiddenButton = hiddenButton
        
        self.rightView = self.hiddenButton
        self.rightViewMode = .whileEditing
        
    }
    
    @objc func setIsSecureEntry() {
        self.isSecureTextEntry = !self.isSecureTextEntry
    }
    
}
