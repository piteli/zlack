//
//  ProfileVC.swift
//  Zlack
//
//  Created by Fitri San on 24/08/2019.
//  Copyright © 2019 pitelichan. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closedModalPressed(_ sender: Any) {
        self.dismiss(animated : true, completion : nil)
    }
    
    @IBAction func logoutModalPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name : NOTIF_USER_DATA_DID_CHANGE, object : nil)
        dismiss(animated : true, completion : nil)
    }
    
    func setupView(){
        userName.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        profileImg.image = UIImage(named : UserDataService.instance.avatarName)
        profileImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        let closeTouch = UITapGestureRecognizer(target : self, action : #selector(ProfileVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer : UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    
}
