//
//  LogInVC.swift
//  PriceTracker
//
//  Created by Michelle Cheung on 4/4/18.
//  Copyright © 2018 MAE. All rights reserved.
//

import UIKit

class LogInVC: UIViewController {
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var logInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var noAccountButton: UIButton!
    
    /* Action that follows pressing the login button */
    @IBAction func logInPressed(_ sender: UIButton) {
        //TODO:
        //Connect the IBAction
        //Fille out the Code. Refer to most recent Snapchat Clone's Log In View Controller

         performSegue(withIdentifier: "login-home", sender: self)
    }
    
    /* Action that follows pressing the sign Up button */
    @IBAction func signUpPressed(_ sender: UIButton) {
        //TODO:
        //connect the Action, make an identifier for the segue, uncomment line below with the name of the segue filled in
        //performSegue(withIdentifier:[NAME THIS SEGUE], sender: self)
        performSegue(withIdentifier: "login-signup", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
