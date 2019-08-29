//
//  ChannelVC.swift
//  Zlack
//
//  Created by Piteli Chan on 8/2/19.
//  Copyright © 2019 pitelichan. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func prepareforUnwind(segue: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad () {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector :#selector(ChannelVC.userDataDidChange(_:)), name : NOTIF_USER_DATA_DID_CHANGE, object : nil)
        // Do any additional setup after loading the view.
        SocketService.instance.getChannel{
            (success) in
            if(success){
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated : Bool){
        setupUserInfo()
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
        setupUserInfo()
    }
    
    func setupUserInfo(){
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            let channel = MessageService.instance.channels[indexPath.row]
            
            // following is from udemy suggestion
            // cell.configureCellChannel(channel : channel)
            
            //following is what xcode suggested
            cell.configureCellChannel(channel : channel)
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    @IBAction func addChannelPressed(_ sender: Any) {
        let addChannel = AddChannelVC()
        addChannel.modalPresentationStyle = .custom
        present(addChannel, animated : true, completion : nil)
    }
    
}
