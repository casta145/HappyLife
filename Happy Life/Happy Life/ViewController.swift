//
//  ViewController.swift
//  Happy Life
//
//  Created by Alfonso Castanos on 11/25/18.
//  Copyright © 2018 Alfonso Castanos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated
    }
    
    //MARK: Actions
    @IBAction func enterButton(_ sender: UIButton) {
        performSegue(withIdentifier: "segueOne", sender: self)
    }

}

