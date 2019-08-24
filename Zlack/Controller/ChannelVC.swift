//
//  ChannelVC.swift
//  Zlack
//
//  Created by Piteli Chan on 8/2/19.
//  Copyright © 2019 pitelichan. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: CircleImage!
    @IBAction func prepareforUnwind(segue: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad () {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector :#selector(ChannelVC.userDataDidChange(_:)), name : NOTIF_USER_DATA_DID_CHANGE, object : nil)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated : true, completion : nil)
        }
        self.revealViewController().revealToggle(self)
        performSegue(withIdentifier: "toLogin", sender: nil)
    }
    
    @objc func userDataDidChange(_ notif : Notification){
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for : .normal)
            userImg.image = UIImage(named : UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named : "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
        }
    }
    
}
