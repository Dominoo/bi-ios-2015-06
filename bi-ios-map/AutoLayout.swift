//
//  AutoLayout.swift
//  bi-ios-map
//
//  Created by Dominik Vesely on 01/12/15.
//  Copyright © 2015 Ackee s.r.o. All rights reserved.
//

import UIKit
import SnapKit



class AutoLayout: UIViewController {

    var blue = true
    var red = true
    
    var v1 : UIView!
    
   
    var x : ConstraintDescriptionEditable!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .whiteColor()
        self.navigationController?.navigationBar.translucent = false
        
        v1 = UIView()
        v1.backgroundColor = .redColor()
        view.addSubview(v1)
        v1.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.view.snp_top).offset(10)
            make.left.equalTo(10)
            x = make.height.equalTo(self.view).multipliedBy(2.0/3.0)
        make.width.equalTo(self.view).dividedBy(2).offset(-10)
        }
        
       let v2 = UIView()
        v2.backgroundColor = .blueColor()
        view.addSubview(v2)
        v2.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(v1)
            make.left.equalTo(v1.snp_right).offset(10)
            make.height.equalTo(v1).dividedBy(2)
            make.right.equalTo(-10)
        }
        
        let v3 = UIView()
        v3.backgroundColor = .greenColor()
        view.addSubview(v3)
        v3.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(-10)
            make.left.equalTo(v1)
            //make.top.equalTo(v1.snp_bottom).offset(10)
            make.height.equalTo(self.view).dividedBy(3).offset(-30)
            make.right.equalTo(-10)

        }
        
    
    }
    
    override func viewDidAppear(animated: Bool) {
    UIView.animateWithDuration(1.5, delay: 2, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            
       self.v1.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.view.snp_top).offset(10)
            make.left.equalTo(10)
            make.height.equalTo(self.view).multipliedBy(1.0/2.0)
            make.width.equalTo(self.view).dividedBy(2).offset(-10)
        }
        
            self.view.layoutIfNeeded()
            
            }) { (bool) -> Void in
                
        }
    }
}
