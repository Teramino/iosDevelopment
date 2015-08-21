//
//  TabVCTemplate.swift
//  LoginWindow
//
//  Created by Kory Brown on 8/19/15.
//  Copyright © 2015 Alpha. All rights reserved.
//

import UIKit

class TabVCTemplate : UIViewController {
    
    override func viewDidLoad() {
        
        // Sent from LeftMenu
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "openPushWindow", name: "openPushWindow", object: nil)
        
//        dispatch_async(dispatch_get_main_queue()) {
//            NSNotificationCenter.defaultCenter().postNotificationName("keepMenuClosed", object: nil)
//        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func openPushWindow(){
        performSegueWithIdentifier("openPushWindow", sender: nil)
    }
    
}