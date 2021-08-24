import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func enterClicked(_ sender: UIButton) {
        self.authenticate()
    }
    
    @IBAction func forgetPasswordClicked(_ sender: UIButton) {
        self.showPasswordRecoveryForm()
    }
    
    func authenticate() {
        self.performSegue(withIdentifier: "LoginToMain", sender: nil)
    }
    
    func showPasswordRecoveryForm() {
        #warning("Implement this method")
        print("Implement method \(#function)")
    }
    
}
