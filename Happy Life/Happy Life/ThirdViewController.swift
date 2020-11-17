//
//  ThirdViewController.swift
//  Happy Life
//
//  Created by Alfonso Castanos on 11/26/18.
//  Copyright © 2018 Alfonso Castanos. All rights reserved.
//

import UIKit

var savedDates : [String] = ["24 December 2018", "25 December 2018"]
var savedEvent : [String] = ["Christmas Eve", "Christmas"]

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func popupEnabler(_ sender: UIButton) {
        let alert = UIAlertController(title: "Settings", message: "You can set up your preferences now or use default preferences.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Use Default", style: UIAlertAction.Style.default, handler: { action in self.showToast(message: "Coming Soon...")}))
        alert.addAction(UIAlertAction(title: "Set Up", style: UIAlertAction.Style.cancel, handler: { action in self.showToast(message: "Coming Soon...")}))
        self.present(alert,animated: true, completion: nil)
    }
    
    @IBAction func calenderSection(_ sender: UIButton) {
        performSegue(withIdentifier: "segueThree", sender: self)
    }
    
    @IBAction func exerciseSection(_ sender: UIButton) {
        showToast(message: "Coming Soon...")
        print(savedDates)
    }
    
    @IBAction func nutritionSection(_ sender: UIButton) {
        showToast(message: "Coming Soon...")
    }
    @IBAction func financeSection(_ sender: UIButton) {
        showToast(message: "Coming Soon...")
    }
    
    func showToast (message: String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2-75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options:.curveEaseOut, animations: { toastLabel.alpha = 0.0}, completion: {(isCompleted) in toastLabel.removeFromSuperview()})
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
