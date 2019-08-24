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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //variables default
    var avatarName = ""
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            user_img.image = UIImage(named : UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            if avatarName.contains("light") && bgColor == nil {
                user_img.backgroundColor = UIColor.lightGray
            }
        }
    }

    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToChannel", sender: nil)
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        guard let name = username_txt.text, username_txt.text != "" else {return}
        guard let email = email_txt.text, email_txt.text != "" else {return}
        guard let pass = password_txt.text, password_txt.text != "" else {return}
        AuthService.instance.registerUser(email: email, password: pass){(success) in
            
            if(success){
                AuthService.instance.loginUser(email : email, password : pass, completion : {
                    (success) in
                    if success {
                        UserDataService.instance.createUser(name : name, email : email, avatarName : self.avatarName, avatarColor : self.avatarColor, completion : {
                            (success) in
                            if success {
                            print(UserDataService.instance.name,UserDataService.instance.avatarName)
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                            self.performSegue(withIdentifier: UNWIND, sender: nil)
                                NotificationCenter.default.post(name : NOTIF_USER_DATA_DID_CHANGE, object : nil)
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
        let r = CGFloat(arc4random_uniform(255) / 255)
        let g = CGFloat(arc4random_uniform(255) / 255)
        let b = CGFloat(arc4random_uniform(255) / 255)
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        avatarColor = "[\(r), \(g), \(b), 1]"
        UIView.animate(withDuration: 0.2) {
            self.user_img.backgroundColor = self.bgColor
        }
    }
    
    func setupView(){
        spinner.isHidden = true
        username_txt.attributedText  = NSAttributedString(string : "username", attributes : [NSAttributedStringKey.foregroundColor : zlackPurplePlaceHolder])
        email_txt.attributedText  = NSAttributedString(string : "email", attributes : [NSAttributedStringKey.foregroundColor : zlackPurplePlaceHolder])
        password_txt.attributedText  = NSAttributedString(string : "password", attributes : [NSAttributedStringKey.foregroundColor : zlackPurplePlaceHolder])
        let tap = UITapGestureRecognizer(target : self, action : #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
}
