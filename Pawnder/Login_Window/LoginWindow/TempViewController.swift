//
//  TempViewController.swift
//  LoginWindow
//
//  Created by Kory Brown on 8/20/15.
//  Copyright © 2015 Alpha. All rights reserved.
//

import UIKit

class TempViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func close(sender: UIButton) {
         dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
