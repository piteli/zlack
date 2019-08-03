//
//  GradientView.swift
//  Zlack
//
//  Created by Piteli Chan on 8/3/19.
//  Copyright © 2019 pitelichan. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) {
        didSet{
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1) {
        didSet{
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y : 0)
        gradientLayer.endPoint = CGPoint(x : 1, y : 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
