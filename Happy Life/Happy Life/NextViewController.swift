//
//  NextViewController.swift
//  Happy Life
//
//  Created by Alfonso Castanos on 12/1/18.
//  Copyright © 2018 Alfonso Castanos. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var eventInfo: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DateLabel.text = dateString
    }
    
    @IBAction func Exit(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submit(_ sender: UIButton) {
        savedDates.append(DateLabel.text!)
        savedEvent.append("\(eventName) \(eventInfo)")
        dismiss(animated: true, completion: nil)
    }
}
