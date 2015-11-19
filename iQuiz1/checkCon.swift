//
//  checkCon.swift
//  iQuiz1
//
//  Created by iGuest on 11/19/15.
//  Copyright © 2015 Jia Yu. All rights reserved.
//

import Foundation
import SystemConfiguration

public class checkCon {
    
    class func isConnectedToNetwork()->Bool{
        
        var Status:Bool = false
        let url = NSURL(string: "http://google.com/")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "HEAD"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        
        var response: NSURLResponse?
        
        if let httpResponse = response as? NSHTTPURLResponse {
            if httpResponse.statusCode == 200 {
                Status = true
            }
            
        }
        
        return Status
    }}
