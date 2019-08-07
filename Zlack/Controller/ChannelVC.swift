//
//  ChannelVC.swift
//  Zlack
//
//  Created by Piteli Chan on 8/2/19.
//  Copyright © 2019 pitelichan. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad () {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        self.revealViewController().revealToggle(self)
        performSegue(withIdentifier: "toLogin", sender: nil)
    }
    
}
