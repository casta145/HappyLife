//
//  Animations.swift
//  Happy Life
//
//  Created by Alfonso Castanos on 12/3/18.
//  Copyright © 2018 Alfonso Castanos. All rights reserved.
//

import UIKit

func MoveAnimationNext(Label: UILabel ){
    let positionAnimation = CABasicAnimation(keyPath: "position")
    positionAnimation.fromValue = NSValue(cgPoint: CGPoint(x: Label.center.x + 70, y: Label.center.y))
    positionAnimation.toValue = NSValue(cgPoint: CGPoint(x: Label.center.x, y: Label.center.y))
    positionAnimation.duration = 0.3
    
    let fadeAnimation = CABasicAnimation(keyPath: "opacity")
    fadeAnimation.fromValue = 0
    fadeAnimation.toValue = 1
    fadeAnimation.duration = 0.3
    
    Label.layer.add(positionAnimation, forKey: nil)
    Label.layer.add(fadeAnimation, forKey: nil)
}

func MoveAnimationBack(Label: UILabel){
    let positionAnimation = CABasicAnimation(keyPath: "position")
    positionAnimation.fromValue = NSValue(cgPoint: CGPoint(x: Label.center.x - 70, y: Label.center.y))
    positionAnimation.toValue = NSValue(cgPoint: CGPoint(x: Label.center.x, y: Label.center.y))
    positionAnimation.duration = 0.3
    
    let fadeAnimation = CABasicAnimation(keyPath: "opacity")
    fadeAnimation.fromValue = 0
    fadeAnimation.toValue = 1
    fadeAnimation.duration = 0.3
    
    Label.layer.add(positionAnimation, forKey: nil)
    Label.layer.add(fadeAnimation, forKey: nil)
}
