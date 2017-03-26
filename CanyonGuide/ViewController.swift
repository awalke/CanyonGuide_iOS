//
//  ViewController.swift
//  CanyonGuide
//
//  Created by Allison Walke on 3/25/17.
//  Copyright © 2017 Sediment Labs. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseDatabase

class ViewController: UIViewController, GIDSignInUIDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var startLabel: UIButton!
    
    @IBAction func startButton(_ sender: Any) {
        print("pass")
        
        let labelValue = "\(startLabel.titleLabel!.text!)"
        
        if (labelValue == "Start") {
            startLabel.setTitle("Stop", for: .normal)
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm'"
            
            let strDate = timeFormatter.string(from: datePicker.date)
            
            let time = "\(strDate)"
            
            FIRDatabase.database().reference().child("messages").setValue(["time": time])
        }
        
        if (labelValue == "Stop") {
            startLabel.setTitle("Start", for: .normal)
            //TODO delete database entry
            
            let item = FIRDatabase.database().reference().child("messages")
            
            item.removeValue()
        
        }
        
        
    }
    
    @IBAction func signOutButton(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
}

