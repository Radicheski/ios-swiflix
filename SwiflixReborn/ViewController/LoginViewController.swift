import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = Auth.auth().currentUser {
            self.showMainScreen()
        }
        
    }
    
    @IBAction func enterClicked(_ sender: UIButton) {
        self.authenticate()
    }
    
    @IBAction func forgetPasswordClicked(_ sender: UIButton) {
        self.showPasswordRecoveryForm()
    }
    
    func authenticate() {
        
        if let email = self.emailField.text,
           let password = self.passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let _ = result {
                    self.showMainScreen()
                } else if let _ = error {
                    #warning("Handle authentication error")
                }
            }
        }
        
    }
    
    func showMainScreen() {
        self.performSegue(withIdentifier: "LoginToMain", sender: nil)
    }
    
    func showPasswordRecoveryForm() {
        self.performSegue(withIdentifier: "LoginToPasswordRecovery", sender: nil)
    }
    
}
