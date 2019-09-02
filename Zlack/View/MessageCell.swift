//
//  MessageCell.swift
//  Zlack
//
//  Created by Fitri San on 02/09/2019.
//  Copyright © 2019 pitelichan. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var CircleImage: CircleImage!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var timestampLbl: UILabel!
    @IBOutlet weak var messageBodyLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(message : Message){
        messageBodyLbl.text = message.message
        usernameLbl.text = message.userName
        CircleImage.image = UIImage(named : message.userAvatar)
        CircleImage.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
    }

}
