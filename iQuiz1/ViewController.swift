//
//  ViewController.swift
//  iQuiz1
//
//  Created by Jia Yu on 11/3/15.
//  Copyright (c) 2015 Jia Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSURLConnectionDelegate, UIPopoverPresentationControllerDelegate{
    
    var data = NSMutableData()
    
    var jsonItem:NSMutableArray!
    
    var urlPath:String!
    
    @IBOutlet weak var newTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        startConnection()
                // Do any additional setup after loading the view, typically from a nib.
    }
    
    func startConnection(){
        if urlPath == nil{
            urlPath = "http://tednewardsandbox.site44.com/questions.json"
            print("nil")
        }
        let url: NSURL = NSURL(string: urlPath)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
        connection.start()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        self.data.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        
        subjects = []
        
        print("connection worked")
        
        let opts = NSJSONReadingOptions(rawValue: 0)
        do{
            
            jsonItem = try NSJSONSerialization.JSONObjectWithData(data, options: opts) as! NSMutableArray
            
            for json in jsonItem as Array<AnyObject>{
                
                let s:subject = subject(title: "", description: "", imageName: "marvel", questions: [])
                
                s.title = (json["title"] as AnyObject? as? String) ?? ""
                
                s.description = (json["desc"] as AnyObject? as? String) ?? ""
                
                for js in json["questions"] as! Array<AnyObject>{
                    
                    let q:question = question(text: "", optionTxt: [], answer: 0)
                    
                    q.text = (js["text"] as AnyObject? as? String) ?? ""
                    
                    q.answer = Int((js["answer"] as AnyObject? as? String) ?? "")!
                    
                    for j in js["answers"] as! Array<AnyObject>{
                        
                        q.optionTxt.append((j as AnyObject? as? String) ?? "")
                        
                    }
                    
                    s.questions.append(q)
                    
                }
                
                subjects.append(s)
                
            }
    
        }
            
        catch {
            
            print("ERROR")
            
        }
        
        newTableView.reloadData()
        
    }
    
    func didSelectButton(aButton: UIButton?) {
        print(aButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickSet(sender: AnyObject) {
        
        self.performSegueWithIdentifier("settings", sender: self)
        
    }


    
    func tableView(tableView: UITableView, numberOfRowsInSection section:Int) -> Int{
        return subjects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) 
        
        let sub = subjects[indexPath.row]
        cell.textLabel?.text = sub.title
        cell.detailTextLabel?.text = sub.description
        cell.imageView?.image = sub.image
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "getQues"){
            
            let svc = segue.destinationViewController as! QuestionViewController
            
            let index = self.newTableView.indexPathForSelectedRow!.row
            
            svc.sub = index
        }
        
        if (segue.identifier == "settings"){
            
            let svc = segue.destinationViewController 
            
            let controller = svc.popoverPresentationController
            
            if controller != nil{
                
                controller?.delegate = self
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    
}

