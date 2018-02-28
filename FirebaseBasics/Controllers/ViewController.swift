//
//  ViewController.swift
//  FirebaseBasics
//
//  Created by Akhil Koothal on 2/23/18.
//  Copyright © 2018 Akhil Koothal. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
import SCLAlertView

class ViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func SignUp(_ sender: Any)
    {
        Auth.auth().createUser(withEmail: emailLabel.text!, password: passwordLabel.text!) {(user,error) in
            if error != nil
            {
                self.errorHandle(error: (error?.localizedDescription)!)
                print("Error",error as Any)
            }
            else
            {
                let uid = Auth.auth().currentUser?.uid
                let ref = Database.database().reference(fromURL: "https://basics-245cd.firebaseio.com/")
                let userRefernce = ref.child("users").child(uid!)
                let values = ["name":self.name.text!,"email":self.emailLabel.text!]
                userRefernce.updateChildValues(values)
                self.performSegue(withIdentifier: "registrationToStorageVC", sender: nil)
               
            }
        };
    }
    
    func errorHandle(error:String)
    {
        SCLAlertView().showError("Error", subTitle: error)
    }
    


}

