//
//  AddChannelVC.swift
//  Zlack
//
//  Created by Fitri San on 27/08/2019.
//  Copyright © 2019 pitelichan. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    //outlets
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var descText: UITextField!
    @IBOutlet weak var bgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func createChannelPressed(_ sender: Any) {
    }
    

    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupView(){
        let clouseTouch = UITapGestureRecognizer(target : self , action : #selector(AddChannelVC.closeTap(_:)))
        nameText.attributedPlaceholder = NSAttributedString(string : "name", attributes : [NSAttributedStringKey.foregroundColor : zlackPurplePlaceHolder])
        descText.attributedPlaceholder = NSAttributedString(string : "description", attributes : [NSAttributedStringKey.foregroundColor : zlackPurplePlaceHolder])
    }
    
    @objc func closeTap(_ recognizer : UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
}
