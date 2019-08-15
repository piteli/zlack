//
//  RoundedButton.swift
//  Zlack
//
//  Created by Piteli Chan on 8/15/19.
//  Copyright © 2019 pitelichan. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    @IBInspectable var corderRadius : CGFloat = 3.00 {
        didSet{
            self.layer.cornerRadius = corderRadius
        }
    }
    
    override func awakeFromNib() {
        self.setView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    func setupView(){
        self.layer.cornerRadius = cornerRadius
    }
}
