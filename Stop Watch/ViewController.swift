//
//  ViewController.swift
//  Stop Watch
//
//  Created by Rudra Jikadra on 26/12/17.
//  Copyright © 2017 Rudra Jikadra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startbtn: UIButton!
    @IBOutlet weak var stopbtn: UIButton!
    @IBOutlet weak var resetbtn: UIButton!
    @IBOutlet weak var lapbtn: UIButton!
    
    @IBOutlet weak var lap1: UILabel!
    @IBOutlet weak var lap2: UILabel!
    @IBOutlet weak var lap3: UILabel!
    
    var l1 = 0
    var l2 = 0
    var l3 = 0
    
    var bgtask = 0
    var timer = Timer()
    var fractions: Int = 0
    var seconds: Int = 0
    var minutes: Int = 0
    
    var lapRecorded: String = ""
    
    var timerStarted: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        timerLabel.text = "00:00.00"
        
        startbtn.isEnabled = true
        stopbtn.isEnabled = false
        resetbtn.isEnabled = false
        lapbtn.isEnabled = false
        
        lap1.isHidden = true
        lap2.isHidden = true
        lap3.isHidden = true
        
    }

    @IBAction func startTimer(_ sender: Any) {
        if timerStarted == false {
            
            if bgtask == 0 {
                bgtask = 1
                registerBackgroundTask()
            }
            timerStarted = true
            
            inBackground()
            
            startbtn.isEnabled = false
            stopbtn.isEnabled = true
            resetbtn.isEnabled = true
            lapbtn.isEnabled = true
        }
    }
    
    @IBAction func stopTimer(_ sender: Any) {
        if timerStarted == true {
            timerStarted = false
            timer.invalidate()
            stopbtn.isEnabled = false
            startbtn.isEnabled = true
            resetbtn.isEnabled = true
            lapbtn.isEnabled = false
            
            if bgtask == 1{
                endBackgroundTask()
                bgtask = 0
            }
        }
    }
    
    @IBAction func resetTimer(_ sender: Any) {
        
        timer.invalidate()
        
         fractions = 0
         seconds = 0
         minutes = 0
        
         timerStarted = false
        
        startbtn.isEnabled = true
        stopbtn.isEnabled = false
        resetbtn.isEnabled = false
        lapbtn.isEnabled = false
        
        timerLabel.text = "00:00.00"
        
        lap1.isHidden = true
        lap2.isHidden = true
        lap3.isHidden = true
        l1 = 0
        l2 = 0
        l3 = 0
        
        if bgtask == 1{
            endBackgroundTask()
            bgtask = 0
        }
    }
    
    @IBAction func lapTimer(_ sender: Any) {
        
        lapRecorded = timerLabel.text!
        
        if l1 == 0 {
            
            lap1.isHidden = false
            lap1.text = "  Lap: \(lapRecorded)"
            l1 = 1
            
        } else if l2 == 0 {
            
            lap2.isHidden = false
            lap2.text = lap1.text
            lap1.text = "  Lap: \(lapRecorded)"
            l2 = 1
            
        } else if l3 == 0 {
            
            lap3.isHidden = false
            lap3.text = lap2.text
            lap2.text = lap1.text
            lap1.text = "  Lap: \(lapRecorded)"
            l3 = 1
            
        } else {
            
            lap3.text = lap2.text
            lap2.text = lap1.text
            lap1.text = "  Lap: \(lapRecorded)"
            
        }
        
    }
    
    
    
    func inBackground() {
        //call endBackgroundTask() on completion..
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func registerBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask()
        }
        assert(backgroundTask != UIBackgroundTaskInvalid)
    }
    
    func endBackgroundTask() {
        
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = UIBackgroundTaskInvalid
    }
    
    
    @objc func updateTimer(){
        fractions += 1
        
        if fractions == 100 {
            fractions = 0
            seconds += 1
        }
        
        if seconds == 60 {
            seconds = 0
            minutes += 1
        }
        
        
        let fracStr: String = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secStr: String = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minStr: String = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        timerLabel.text = "\(minStr):\(secStr).\(fracStr)"
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}




