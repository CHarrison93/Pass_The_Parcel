//
//  Utils.swift
//  Pass The Parcel Updated
//
//  Created by Chris Harrison on 17/10/2016.
//  Copyright © 2016 Chris Harrison. All rights reserved.
//

import Foundation
import UIKit

class Utils{
    
    
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    

    func addImage(item: UIImageView!,frameX: CGFloat!,frameY: CGFloat!,frameW: CGFloat!,frameH: CGFloat!, imageName: String!,interactionEnabled: Bool!)->UIImageView{
        let item = UIImageView(frame:CGRect(x: frameX, y: frameY, width: frameW, height: frameH))
        item.image = (UIImage(named: imageName))
        item.center = CGPoint(x: frameX, y: frameY)
        item.isUserInteractionEnabled = interactionEnabled
        
        return item
    }
    
    func addSection(x:CGFloat!,y:CGFloat!,w:CGFloat!,h:CGFloat!)->UIImageView{
        //Add First Seection
        let item = UIImageView(frame: CGRect(x:x, y:y, width:w, height:h))
        item.backgroundColor = UIColor.white
        item.alpha = 0.8
        item.layer.cornerRadius = 12.0
        item.layer.borderColor = UIColor.black.cgColor
        item.layer.borderWidth = 3
        item.clipsToBounds = true
        item.center = CGPoint(x: x, y: y)
        item.isUserInteractionEnabled = true
        
        return item
    }
    func addGradientToSection(item: CAGradientLayer!)->CAGradientLayer{
        let item = CAGradientLayer()
        item.frame = CGRect(x: 0, y: 0, width: width, height: height)
        item.colors = [UIColor(red: 1.0/255, green: 215.0/255, blue: 225.0/255, alpha: 1.0).cgColor, UIColor(red: 200.0/255, green: 250.0/255, blue: 245.0/255, alpha: 0.9).cgColor]
        item.locations = [0.0, 1.0]
        item.startPoint = CGPoint(x: 0.0, y: 0.5)
        item.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        return item
    }
    
    func createGradientLayer()->CAGradientLayer{
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
        gradientLayer.colors = [UIColor(red: 255.0/255, green: 55.0/255, blue: 85.0/255, alpha: 1.0).cgColor, UIColor(red: 255.0/255, green: 80.0/255, blue: 60.0/255, alpha: 0.5).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        return gradientLayer
    }
    
    func changeGradientPosition(){
        if gradientDecreasing == true{
            if gradientLocationX <= gradientMin {
                gradientDecreasing = false
                gradientLocationX = gradientLocationX + gradientSpeed
                gradientLocationY = gradientLocationY + gradientSpeed
            }
            else{
                gradientLocationX = gradientLocationX - gradientSpeed
                gradientLocationY = gradientLocationY - gradientSpeed
            }
        }
        else{
            gradientLocationX = gradientLocationX + gradientSpeed
            gradientLocationY = gradientLocationY + gradientSpeed
            if gradientLocationX >= gradientMax {
                gradientDecreasing = true
                gradientLocationX = gradientLocationX - gradientSpeed
                gradientLocationY = gradientLocationY - gradientSpeed
            }
            else{
                gradientLocationX = gradientLocationX + gradientSpeed
                gradientLocationY = gradientLocationY + gradientSpeed
            }
        }
        gradientLayer.locations = [NSNumber(value:gradientLocationX), NSNumber(value:gradientLocationY)]
        //gradientModeLayer.locations = [NSNumber(value:gradientLocationX), NSNumber(value:gradientLocationY)]
        //gradientModeLayer2.locations = [NSNumber(value:gradientLocationX), NSNumber(value:gradientLocationY)]
    }
    
    func gradientToGreen(ToGreen:CAGradientLayer,ToRed:CAGradientLayer){
        
        UIView.animate(withDuration: 0.8, delay: 0, options: UIViewAnimationOptions.autoreverse, animations: {
            ToGreen.colors = [UIColor(red: 20.0/255, green: 220.0/255, blue: 80.0/255, alpha: 1.0).cgColor, UIColor(red: 20.0/255, green: 240.0/255, blue: 90.0/255, alpha: 0.9).cgColor]
            ToRed.colors = [UIColor(red: 1.0/255, green: 215.0/255, blue: 225.0/255, alpha: 1.0).cgColor, UIColor(red: 200.0/255, green: 250.0/255, blue: 245.0/255, alpha: 0.9).cgColor]
        }, completion: nil)
        
    }
    
    
    
    
    func miniPulse(itemPulse: UIImageView!, Duration: TimeInterval!, Delay: TimeInterval!){
        UIView.animate(withDuration: Duration, delay: Delay, options: [UIViewAnimationOptions.allowUserInteraction, UIViewAnimationOptions.autoreverse, UIViewAnimationOptions.repeat], animations: {
            itemPulse.transform = CGAffineTransform.identity.scaledBy(x: 1.05, y: 1.05)
            }, completion: { (finish) in
                UIView.animate(withDuration: Duration, animations: {
                    itemPulse.transform = CGAffineTransform.identity
                })
        })
    }
    func pulse(itemPulse: UIImageView!, Duration: TimeInterval!, Delay: TimeInterval!){
        UIView.animate(withDuration: Duration, delay: Delay, options: [UIViewAnimationOptions.allowUserInteraction, UIViewAnimationOptions.autoreverse, UIViewAnimationOptions.repeat], animations: {
            itemPulse.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
            }, completion: { (finish) in
                UIView.animate(withDuration: Duration, animations: {
                    itemPulse.transform = CGAffineTransform.identity
                })
        })
    }
    func bigPulse(itemPulse: UIImageView!, Duration: TimeInterval!, Delay: TimeInterval!){
        UIView.animate(withDuration: Duration, delay: Delay, options: [UIViewAnimationOptions.allowUserInteraction, UIViewAnimationOptions.autoreverse, UIViewAnimationOptions.repeat], animations: {
            itemPulse.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
            }, completion: { (finish) in
                UIView.animate(withDuration: Duration, animations: {
                    itemPulse.transform = CGAffineTransform.identity
                })
        })
    }
    
    func popItem(Duration: Double!, Delay: Double!, PopImage: UIImageView!, PositionX: CGFloat!, PositionY: CGFloat!, Width: CGFloat!, Height: CGFloat! ){
        
        UIImageView.animate(withDuration: Duration, delay: Delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            PopImage.frame = CGRect(x: PositionX, y: PositionY, width: Width, height: Height)
            PopImage.center = CGPoint(x: PositionX, y: PositionY)
            }, completion: nil)
        
    }
    
    func popTextBox(Duration: Double!, Delay: Double!, PopImage: UITextView!, PositionX: CGFloat!, PositionY: CGFloat!, Width: CGFloat!, Height: CGFloat! ){
        
        UITextView.animate(withDuration: Duration, delay: Delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            PopImage.frame = CGRect(x: PositionX, y: PositionY, width: Width, height: Height)
            PopImage.center = CGPoint(x: PositionX, y: PositionY)
            }, completion: nil)
        
    }
    
    
    
    
    


    
}


