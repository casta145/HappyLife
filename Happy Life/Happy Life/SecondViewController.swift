//
//  SecondViewController.swift
//  Happy Life
//
//  Created by Alfonso Castanos on 11/25/18.
//  Copyright © 2018 Alfonso Castanos. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Action
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signinButton(_ sender: UIButton) {
        if (emailTextField.text != "" && passTextField.text != "") {
            performSegue(withIdentifier: "segueTwo", sender: self)
        } else {
            emailTextField.text = ""
            passTextField.text = ""
        }
    }
}
