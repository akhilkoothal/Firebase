//
//  CardAuthenticationVC.swift
//  FirebaseBasics
//
//  Created by Akhil Koothal on 2/26/18.
//  Copyright © 2018 Akhil Koothal. All rights reserved.
//

import UIKit
import Stripe




class CardAuthenticationVC: UIViewController, STPPaymentCardTextFieldDelegate {
    
    var paymentTextField = STPPaymentCardTextField()
    var amount = STPPaymentCardTextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        let paymentFrame = CGRect(x: 20, y: 150, width: self.view.frame.size.width - 40, height: 40)
        paymentTextField = STPPaymentCardTextField(frame: paymentFrame)
        paymentTextField.center = view.center
        paymentTextField.delegate = self
        view.addSubview(paymentTextField)
        
        // Do any additional setup after loading the view.
    }
    
    func paymentCardTextFieldDidEndEditingNumber(_ textField: STPPaymentCardTextField) {
        print("Card Number: ",paymentTextField.cardNumber)
    }

}
