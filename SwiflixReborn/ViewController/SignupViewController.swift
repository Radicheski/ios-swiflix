import UIKit

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
        self.performSegue(withIdentifier: "SignupToMain", sender: nil)
    }
    
}
