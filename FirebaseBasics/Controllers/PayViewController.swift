//
//  ViewController.swift
//  stripeProject
//
//  Created by Akhil Koothal on 2/25/18.
//  Copyright © 2018 Akhil Koothal. All rights reserved.
//

import UIKit
import Stripe
import CoreGraphics
import SVProgressHUD
import AVKit
import SCLAlertView






class PayViewController: UIViewController, STPPaymentCardTextFieldDelegate {
    
    @IBOutlet weak var payButton: UIButton!
    var paymentTextField: STPPaymentCardTextField!
//    let player = ASPVideoPlayerView()

    @IBAction func paymentDoneButton(_ sender: Any)
    {
        let alert = SCLAlertView()
        alert.addButton("Submit", action: {
            self.dismiss(animated: true, completion: nil)
        })
        alert.showSuccess("Submit", subTitle: "Transcation will be completed press submit!", closeButtonTitle:"Cancel")
    }
    
    override func viewDidLoad() {
        // add stripe built-in text field to fill card information in the middle of the view
        super.viewDidLoad()
        
        //video()
        
        let frame1 = CGRect(x: 20, y: 150, width: self.view.frame.size.width - 40, height: 40)
        paymentTextField = STPPaymentCardTextField(frame: frame1)
        paymentTextField.center = view.center
        paymentTextField.delegate = self
        view.addSubview(paymentTextField)
        //disable payButton if there is no card information
        //payButton.enabled = false
        
    }
//    func paymentCardTextFieldDidEndEditingCVC(_ textField: STPPaymentCardTextField) {
//         print("Card Number: \(paymentTextField.cardNumber!)")
//    }
    
    
    }
    
    
   
    

