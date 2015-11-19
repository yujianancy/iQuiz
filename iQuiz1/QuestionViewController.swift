//
//  QuestionViewController.swift
//  iQuiz1
//
//  Created by iGuest on 11/7/15.
//  Copyright © 2015 Jia Yu. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var quesTxt: UILabel!
    
    @IBOutlet weak var options: UIPickerView!
    
    @IBOutlet weak var record: UILabel!
    
    @IBAction func clickBack(sender: AnyObject) {
        
        self.performSegueWithIdentifier("backToMain", sender: self)
        
    }
    
    @IBOutlet weak var correctAns: UILabel!
    
    var sub:Int!
    
    var curQues:question!
    
    var curIndex:Int = 0
    
    var optionSelected:Int!
    
    var ansCorrect:Int = 0
    
    @IBAction func clickNext(sender: AnyObject) {
        
        if (optionSelected == nil){
            
            optionSelected = 0
            
        }
            
        if (optionSelected == curQues.answer){
                
            ansCorrect = ansCorrect + 1
                
        }
        
        self.performSegueWithIdentifier("showAns", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "showAns"){
            
            let svc = segue.destinationViewController as! AnswerViewController
            
            svc.yans = curQues.optionTxt[curQues.answer]
            
            svc.curQues = curQues
            
            svc.optionSelected = optionSelected
            
            svc.ansCorrect = ansCorrect
            
            svc.sub = sub
            
            svc.curIndex = curIndex
        }

    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quesTxt.numberOfLines = 0
        
        curQues = subjects[sub].questions[curIndex]
        
        quesTxt.text = curQues.text
        
        options.delegate = self
        
        options.dataSource = self
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        
        self.view.addGestureRecognizer(swipeRight)
        
        // Do any additional setup after loading the view.
    }
    
    func respondToSwipeGesture(gesture:UIGestureRecognizer){
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            
            switch swipeGesture.direction{
                
            case UISwipeGestureRecognizerDirection.Left:
                
                if (optionSelected == nil){
                    
                    optionSelected = 0
                    
                }
                
                if (optionSelected == curQues.answer){
                    
                    ansCorrect = ansCorrect + 1
                    
                }
                
                self.performSegueWithIdentifier("showAns", sender: self)
                
            case UISwipeGestureRecognizerDirection.Right:
                
                self.performSegueWithIdentifier("backToMain", sender: self)
                
            default:
                
                break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return curQues.optionTxt[row]
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return curQues.optionTxt.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        optionSelected = row
        
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
