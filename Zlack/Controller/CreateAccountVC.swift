//
//  CreateAccountVC.swift
//  Zlack
//
//  Created by Piteli Chan on 8/6/19.
//  Copyright © 2019 pitelichan. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    //outlets
    @IBOutlet weak var email_txt: UITextField!
    @IBOutlet weak var username_txt: UITextField!
    @IBOutlet weak var password_txt: UITextField!
    @IBOutlet weak var user_img: UIImageView!
    
    //variables default
    var avatarName = ""
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToChannel", sender: nil)
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        guard let name = username_txt, username_txt.text != "" else {return}
        guard let email = email_txt.text, email_txt.text != "" else {return}
        guard let pass = pass_txt.text, pass_txt.text != "" else {return}
        AuthService.instance.registerUser(email: email, password: pass){(success) in
            
            if(success){
                AuthService.instance.loginUser(email : email, password : pass, completion : {
                    (success) in
                    if success {
                        AuthService.instance.createUser(name : name, email : email, avatarName : self.avatarName, avatarColor : self.avatarColor, completion : {
                            (success) in
                            if success {
                            print(UserDataService.instance.name,UserDataService.instance.avatarName)
                            self.performSegue(withIdentifier: UNWIND, sender: nil)
                            }
                        })
                    }
                })
            }
        }
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    @IBAction func pickBGColorPressed(_ sender: Any) {
    }
}
