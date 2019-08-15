//
//  CreateAccountVC.swift
//  Zlack
//
//  Created by Piteli Chan on 8/6/19.
//  Copyright © 2019 pitelichan. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var email_txt: UITextField!
    @IBOutlet weak var username_txt: UITextField!
    @IBOutlet weak var password_txt: UITextField!
    @IBOutlet weak var user_img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToChannel", sender: nil)
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        guard let email = email_txt.text, email_txt.text != "" else {return}
        guard let pass = pass_txt.text, pass_txt.text != "" else {return}
        AuthService.instance.registerUser(email: email, password: pass){(success) in
            
            if(success){
                print("Registered User!")
            }
        }
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
    }
    @IBAction func pickBGColorPressed(_ sender: Any) {
    }
}
