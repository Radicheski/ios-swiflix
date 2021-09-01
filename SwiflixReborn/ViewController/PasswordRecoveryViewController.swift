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
                if let error = error as NSError? {
                   let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                       alert.dismiss(animated: true, completion: nil)
                   }))
                   self.present(alert, animated: true)
               } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
}
