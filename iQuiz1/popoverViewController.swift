//
//  PopoverViewController.swift
//  iQuiz1
//
//  Created by iGuest on 11/19/15.
//  Copyright © 2015 Jia Yu. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {
    @IBOutlet weak var urlText: UITextField!
    
    var urlPath:String!
    
    @IBAction func refreshURL(sender: AnyObject) {
        
        self.performSegueWithIdentifier("refresh", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "refresh"{
            let svc = segue.destinationViewController as! ViewController
            svc.urlPath = urlPath
        }
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlPath = self.urlText.text
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
