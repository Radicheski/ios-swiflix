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
                }  else if let error = error as NSError? {
                    let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true)
                }
            }
        
        }
    }
    
}
