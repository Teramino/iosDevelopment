//
//  HomeScreen.swift
//  LoginWindow
//
//  Created by Kory Brown on 8/13/15.
//  Copyright © 2015 Alpha. All rights reserved.
//

import UIKit

class HomeScreen: UIViewController {
    
     // Need a handle to the scrollView to open and close the menu
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    // This value matches the left menu's width in the Storyboard
    let leftMenuWidth:CGFloat = 260
    
    override func viewDidLoad() {
        
        // Initially close menu programmatically.  This needs to be done on the main thread initially in order to work.
        dispatch_async(dispatch_get_main_queue()) {
            self.closeMenu(false)
        }
        
        // Tab bar controller's child pages have a top-left button toggles the menu
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "toggleMenu", name: "toggleMenu", object: nil)
        
        // Close the menu when the device rotates
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        // LeftMenu sends openModalWindow
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "openWindow", name: "openWindow", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keepMenuClosed", name: "keepMenuClosed", object: nil)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        var nav = self.navigationController?.navigationBar
        nav?.removeFromSuperview()
    }
    
    // Cleanup notifications added in viewDidLoad
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func openWindow(){
        performSegueWithIdentifier("PopupNigga", sender: nil)
    }
    
    func toggleMenu(){
        scrollView.contentOffset.x == 0  ? closeMenu() : openMenu()
    }
    
    // Use scrollview content offset-x to slide the menu.
    func closeMenu(animated:Bool = true){
        scrollView.setContentOffset(CGPoint(x: leftMenuWidth, y: 0), animated: animated)
    }
    
    func keepMenuClosed(){
        print("Closing")
            self.closeMenu(false)
    }
    
    // Open is the natural state of the menu because of how the storyboard is setup.
    func openMenu(){
        print("opening menu")
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    // see http://stackoverflow.com/questions/25666269/ios8-swift-how-to-detect-orientation-change
    // close the menu when rotating to landscape.
    // Note: you have to put this on the main queue in order for it to work
    func rotated(){
        if UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation) {
            dispatch_async(dispatch_get_main_queue()) {
                print("closing menu on rotate")
                self.closeMenu()
            }
        }
    }

    
}
