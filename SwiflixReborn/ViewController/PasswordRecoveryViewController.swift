import UIKit
import FirebaseAuth

class PasswordRecoveryViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendEmail(_ sender: UIButton) {
        if let email = self.emailField.text {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let _ = error {
                    #warning("Handle this error")
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
}
