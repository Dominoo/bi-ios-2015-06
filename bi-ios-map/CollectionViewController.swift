//
//  CollectionViewController.swift
//  bi-ios-map
//
//  Created by Dominik Vesely on 24/11/15.
//  Copyright © 2015 Ackee s.r.o. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class CollectionViewController : UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    weak var collection : UICollectionView?
    var data = [[String: AnyObject]]() {
        didSet {
            collection?.reloadData()
        }
    }
    
    
    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = .whiteColor()
        
        let coll = UICollectionView(frame: self.view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        coll.delegate = self
        coll.dataSource = self
        coll.backgroundColor = .redColor()
        coll.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        self.view.addSubview(coll)
        collection = coll
        coll.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
        
        
    }
    
    ////MARK: Delegates 
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collection!.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        cell.backgroundColor = .whiteColor()
        
        let imgV = UIImageView(frame: cell.contentView.bounds)
        cell.addSubview(imgV)
        
        
        let dict = data[indexPath.item]
        var urlString : String
        if let url = dict["image_url"] as? [String] {
            urlString = url.first!
        } else {
            urlString = dict["image_url"] as! String
        }
        imgV.sd_setImageWithURL(NSURL(string: urlString), placeholderImage: UIImage(named: "bageta"))
        
        return cell;
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5);

    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(100, 100);

    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5
    }
   
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5
    }
    
   
    
   

}
