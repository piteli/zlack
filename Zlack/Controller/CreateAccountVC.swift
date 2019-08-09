//
//  CreateAccountVC.swift
//  Zlack
//
//  Created by Piteli Chan on 8/6/19.
//  Copyright © 2019 pitelichan. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToChannel", sender: nil)
    }
}
