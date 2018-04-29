//
//  SignUpVC.swift
//  PriceTracker
//
//  Created by Michelle Cheung on 4/4/18.
//  Copyright © 2018 MAE. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SignUpVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var hasAccountButton: UIButton!
    
    var userEmail = ""
    var userName = ""
    var userPassword = ""
    var userVerifiedPassWord = ""
    
    let dbRef = Database.database().reference()
    
    /* Actions following pressing the Sign up button. */
    @IBAction func signUpPressed(_ sender: UIButton) {
        //TODO:
        //connect action with storyboard item
        //Refer to signUpViewController file in the last Snapchat lab for reference
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let name = usernameTextField.text else { return }
        guard let verifiedPassword = confirmPasswordTextField.text else { return }
        if email == "" || password == "" || name == "" || verifiedPassword == "" {
            let alertController = UIAlertController(title: "Form Error.", message: "Please fill in form completely.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if error == nil {
                    let changeReq = user!.createProfileChangeRequest()
                    changeReq.displayName = name
                    changeReq.commitChanges(completion:
                        { (err) in
                    })
                    
                    
                    var friends = [self.userName]
                    var itemList = [""]
                
                    
                    let newItemRef = self.dbRef.child("items").childByAutoId()
                    let newItemId = newItemRef.key
                    let newItemData = [
                        "itemname" : "My Cool Shoes",
                        "link" : "None",
                        "size" : "M",
                        "color" : "blizzard blue"]
                    newItemRef.setValue(newItemData)
                    itemList[0] = newItemId
                    
                    let newUserRef = self.dbRef.child("users").child((user?.uid)!)
                    let newUserData = [
                        "username" : self.userName,
                        "email" : self.userEmail]
                    newUserRef.setValue(newUserData)
                    self.dbRef.child("users").child((user?.uid)!).child("friendList").setValue(friends)
                    self.dbRef.child("users").child((user?.uid)!).child("itemList").setValue(itemList)
                    
//                    self.dbRef.child("items").childByAutoId().child("itemname").setValue("My Cool Shoes")
//                    self.dbRef.child("items").childByAutoId().child("link").setValue("None")
//                    self.dbRef.child("items").childByAutoId().child("size").setValue("M")
//                    self.dbRef.child("items").childByAutoId().child("color").setValue("blizzard blue")
                    
                    
                    
                    let alertController = UIAlertController(title: "Congratulations!", message: "You have successfully signed up", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler:
                        {
                            [unowned self] (action) -> Void in
                            self.performSegue(withIdentifier: "signup-home", sender: self)
                    }))
                    self.present(alertController, animated: true, completion: nil)
                } else if password != verifiedPassword {
                    let alertController = UIAlertController(title: "Verification Error.", message: "The two passwords do not match.", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.confirmPasswordTextField.textColor = UIColor.red
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "Sign Up Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.logoImage.image = #imageLiteral(resourceName: "WishList Logo.png")
        self.usernameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.confirmPasswordTextField.delegate = self
        


        // Do any additional setup after loading the view.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.emailTextField {
            if textField.text != nil {
                self.userEmail = textField.text!
            }
        } else if textField == self.passwordTextField {
            if textField.text != nil {
                self.userPassword = textField.text!
            }
        } else if textField == self.usernameTextField {
            if textField.text != nil {
                self.userName = textField.text!
            }
        } else if textField == self.confirmPasswordTextField {
            if textField.text != nil {
                self.userVerifiedPassWord = textField.text!
            }
        }
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
