//
//  LogInVC.swift
//  PriceTracker
//
//  Created by Michelle Cheung on 4/4/18.
//  Copyright © 2018 MAE. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var logInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var noAccountButton: UIButton!

    var userEmail = ""
    var userPassword = ""

    /* Action that follows pressing the login button */
    @IBAction func logInPressed(_ sender: UIButton) {
        guard let emailText = emailTextField.text else { return }
        guard let passwordText = passwordTextField.text else { return }
        
        if emailText == "" || passwordText == "" {
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields
            let alertController = UIAlertController(title: "Log In Error", message: "Please enter an email and password.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            Auth.auth().signIn(withEmail: emailText, password: passwordText) { (user, error) in
                if error == nil {
                    self.performSegue(withIdentifier: "login-home", sender: self)
                    
                } else {
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Log In Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    /* Action that follows pressing the sign Up button */
    @IBAction func signUpPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "login-signup", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.logoImage.image = #imageLiteral(resourceName: "WishList Logo.png")
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    // Authenticate users automatically if they already signed in earlier.
//    override func viewDidAppear(_ animated: Bool) {
//        if Auth.auth().currentUser?.displayName != nil {
//            performSegue(withIdentifier: "login-home", sender: self)
//        }
//    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.emailTextField {
            if textField.text != nil {
                self.userEmail = textField.text!
            }
        } else {
            if textField.text != nil {
                self.userPassword = textField.text!
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
