//
//  LoginVC.swift
//  Zlack
//
//  Created by Piteli Chan on 8/6/19.
//  Copyright © 2019 pitelichan. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let username = userNameTxt.text, userNameTxt.text != "" else {return}
        guard let password = passwordTxt.text, passwordTxt.text != "" else {return}
        
        AuthService.instance.loginUser(email : username, password : password){
            (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: {
                    (success) in
                    if success {
                        NotificationCenter.default.post(name : NOTIF_USER_DATA_DID_CHANGE, object : nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signupBtnPressed(_ sender: Any) {
        performSegue(withIdentifier : "toCreateAccount", sender: nil)
    }
    
    func setupView(){
        spinner.isHidden = true
        userNameTxt.attributedText  = NSAttributedString(string : "Username", attributes : [NSAttributedStringKey.foregroundColor : zlackPurplePlaceHolder])
        passwordTxt.attributedText  = NSAttributedString(string : "Password", attributes : [NSAttributedStringKey.foregroundColor : zlackPurplePlaceHolder])
        let tap = UITapGestureRecognizer(target : self, action : #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
}
