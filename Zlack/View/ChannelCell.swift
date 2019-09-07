//
//  ChannelCell.swift
//  Zlack
//
//  Created by Fitri San on 26/08/2019.
//  Copyright © 2019 pitelichan. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {
    
    
    @IBOutlet weak var channelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.layer.backgroundColor = UIColor(white : 1, alpha : 0.2).cgColor
        }else{
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func configureCellChannel(channel : Channel){
        let title = channel.channelTitle ?? ""
        channelName.text = "#\(title)"
        channelName.font = UIFont(name : "Helvetica-Neue-Regular", size : 17)
        
        for id in MessageService.instance.unreadChannels {
            if id == channel.id {
                channelName.font = UIFont(name : "HelveticaNeue-Bold", size : 22)
            }
        }
    }

}
