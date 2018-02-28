//
//  SignInVC.swift
//  FirebaseBasics
//
//  Created by Akhil Koothal on 2/23/18.
//  Copyright © 2018 Akhil Koothal. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import SCLAlertView
import ChameleonFramework


class SignInVC: UIViewController {
    @IBOutlet var colorfulUI: UIView!
    
    @IBOutlet weak var registrationButton: UIButton!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    var titleValue : String?
    
    
    override func viewWillAppear(_ animated: Bool) {
        buttonUI()
        //self.navigationController?.navigationBar.barTintColor = UIColor.flatOrange

    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func buttonUI()
    {
        signInButton.backgroundColor = UIColor.flatOrange
        signInButton.layer.cornerRadius = 10
        signInButton.layer.borderWidth = 1
        
        registrationButton.layer.cornerRadius = 10
        registrationButton.layer.borderWidth = 1
        registrationButton.layer.borderColor = UIColor.flatOrange.cgColor
    }


    @IBAction func registrationAction(_ sender: Any) {
        performSegue(withIdentifier: "RegistrationSegue", sender: nil)
    }
    @IBAction func signInAction(_ sender: Any)
    {
        Auth.auth().signIn(withEmail: userEmail.text!, password: userPassword.text!) {(user,error) in
            if error != nil
            {
                self.alertBox(error: (error?.localizedDescription)!)
                print("Errors ",error!.localizedDescription as Any)
            }
            else
            {
                let userID = Auth.auth().currentUser?.uid
                let ref = Database.database().reference()
                ref.child("users").child(userID!).observeSingleEvent(of: .value, with: {(snapshot) in

                    let value = snapshot.value as? [String: AnyObject]
                    print("value: ",value)
                    let username = value?["name"]!
                    self.titleValue = username as? String
                    print("title: ",self.titleValue as Any)
                    self.navigationItem.title = username as? String
                })
                self.performSegue(withIdentifier: "WelcomePage", sender: nil)
                print("Successful Login")
                
            }
        };
        
    }
    
    func alertBox(error:String)
    {
        
            SCLAlertView().showError("Error", subTitle: error)
//        else if(alertBoxValue==2)
//        {
//            let alert = SCLAlertView()
//
//            alert.addButton("Submit", action: {
//                self.performSegue(withIdentifier: "WelcomePage", sender: nil)
//            })
//            alert.showSuccess("Sucess", subTitle: "LOG IN successful", closeButtonTitle:nil duration:0.0f)
//        }

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WelcomePage"
        {
            print("titleValue: \(titleValue)")
            let destination = segue.destination as? StorageVC
            
            destination?.NavTitle = titleValue
        }
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
