//
//  ChatVC.swift
//  Zlack
//
//  Created by Piteli Chan on 8/2/19.
//  Copyright © 2019 pitelichan. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        // Do any additional setup after loading the view.
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: {
                (success) in
                NotificationCenter.default.post(name : NOTIF_USER_DATA_DID_CHANGE, object : nil)
            })
        }
        MessageService.instance.findAllChannel { (success) in
            debugPrint(success)
        }
    }

}
