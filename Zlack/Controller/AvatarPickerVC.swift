//
//  AvatarPickerVCViewController.swift
//  Zlack
//
//  Created by Piteli Chan on 8/18/19.
//  Copyright © 2019 pitelichan. All rights reserved.
//

import UIKit

class AvatarPickerVCViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //outlets
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //variables
    var avatarType = AvatarType.dark
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self;
        collectionView.dataSource = self;
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, callForItemAtIndexPath : IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell {
            cell.configureCell(index : indexPath.item, type : avatarType)
            return cell
        }
        return AvatarCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //for other iphone models - smaller screen
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numberOfColumn : CGFloat = 3
        if UIScreen.main.bounds.width > 320 {
            numberOfColumn = 4
        }
        let spaceBetweenCells : CGFloat = 10
        let padding : CGFloat = 40
        let cellDimension = ((collection.bounds.width - padding) - (numberOfColumns - 1) * spaceBetweenCells) / numberOfColumn
        return CGSize(width : cellDimension, height : cellDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        }else{
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        self.dismiss(animated : true, completion : nil)
    }
    
    @IBAction func segmentControlChanged(_ sender: Any) {
        if(segmentControl.selectedSegmentIndex == 0){
            avatarType = .dark
        }else{
            avatarType = .light
        }
        collectionView.reloadData()
    }
}
