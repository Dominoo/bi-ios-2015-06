//
//  ViewController.swift
//  bi-ios-map
//
//  Created by Dominik Vesely on 24/11/15.
//  Copyright © 2015 Ackee s.r.o. All rights reserved.
//

import UIKit
import SnapKit
import _500px_iOS_api


class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
        
        weak var tableView : UITableView!
        
        let data = ["Search By Term","Search by location","upload phototo"]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let table = UITableView()
            table.delegate = self
            table.dataSource = self
            table.tableFooterView = UIView()
            table.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            self.view.addSubview(table)
            tableView = table
            
            table.snp_makeConstraints { (make) -> Void in
                make.edges.equalTo(self.view)
            }
        }
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        //MARK: tablestuff
        
        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 3
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
            
            cell.textLabel?.text = data[indexPath.row]
            return cell
        }
        
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            
            switch indexPath.row {
                
            case 0:
                let alert = createAlertController()
                self.presentViewController(alert, animated: true, completion: nil)
                
            case 1:
                self.navigationController?.pushViewController(MapController(), animated: true)
            case 2:
                self.navigationController?.pushViewController(AutoLayout(), animated: true)
                
               /* let mv = MapViewController()
                self.navigationController?.pushViewController(mv, animated: true)*/
                
                
                
                
            default: return
                
            }
        }
    
    func createAlertController() -> UIAlertController {
        
        let alert = UIAlertController(title: "Search 500px", message: "Enter text!", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler { (text : UITextField) -> Void in
            text.placeholder = "Type here"
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action :UIAlertAction) -> Void in
            
        }
        
        let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { _ in
            
            guard let textfields = alert.textFields, first = textfields.first else {
                return
            }
            
            let text = first.text!
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            PXRequest.init(forSearchTerm: text, page: 1, resultsPerPage: 60, completion: { (data: ([NSObject : AnyObject]!), error: NSError!) -> Void in
                print(data);
                let cv = CollectionViewController()
                let photos = data["photos"] as! [[String : AnyObject]]
                cv.data = photos
                self.navigationController?.pushViewController(cv, animated: true)
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false

            })
            
         
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        
        return alert
        
    }


}

