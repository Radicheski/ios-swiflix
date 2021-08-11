//
//  WelcomeViewController.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 11/08/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startClicked(_ sender: UIButton) {
        self.showLoginForm()
    }
    
    @IBAction func signupClicked(_ sender: UIButton) {
        self.showSignupForm()
    }
    
    func showLoginForm() {
        self.performSegue(withIdentifier: "WelcomeToLogin", sender: nil)
    }
    
    func showSignupForm() {
        self.performSegue(withIdentifier: "WelcomeToSignup", sender: nil)
    }

}
