import UIKit
import FirebaseAuth

class SignupViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signupClicked(_ sender: UIButton) {
        self.signup()
    }
    
    func signup() {
        
        if let email = self.emailField.text,
           let password = self.passwordField.text {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let _ = result {
                    self.performSegue(withIdentifier: "SignupToMain", sender: nil)
                } else if let _ = error {
                    #warning("Handle authentication error")
                }
            }
        
        }
    }
    
}
