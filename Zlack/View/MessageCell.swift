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
        
        //2017-07-13T21:49:25.590z
        guard var isoDate = message.timeStamp else { return }
        let end = isoDate.index(isoDate.endIndex, offsetBy : -5)
        isoDate = isoDate.substring(to : end)
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from : isoDate.appending("Z"))
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from  : finalDate)
            timestampLbl.text = finalDate
        }
    }

}
