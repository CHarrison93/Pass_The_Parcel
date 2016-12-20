//
//  ViewController.swift
//  Pass The Parcel Updated
//
//  Created by Chris Harrison on 07/10/2016.
//  Copyright © 2016 Chris Harrison. All rights reserved.
//

import UIKit
import AVFoundation

var iPad = defaults.bool(forKey: "iPad")
var gradientLayer: CAGradientLayer!

var colorSets = [[CGColor]]()
var gradientLocationX: Float = 0.25
var gradientLocationY: Float = 1.25
var currentColorSet: Int!
var currentLocationSet: Int!
var gradientTimer = Timer()
var gradientDecreasing = true
var gradientSpeed: Float = 0.005
var gradientMax: Float = 0.25
var gradientMin: Float = -0.25

let width = UIScreen.main.bounds.size.width
let height = UIScreen.main.bounds.size.height


class ViewController: UIViewController {
    
    let music = Music()
    var Timer1: Timer!
    
    var present: UIImageView!
    var passTitle: UIImageView!
    var play: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        music.startBackgroundMusic()
        music.prepShakeSound()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        createGradientLayer()
        addImages()
        addGestures()
    }
    override func viewDidAppear(_ animated: Bool) {
        
        var presentWidth = width*0.6
        var presentHeight = width*0.4
        var titleWidth = width*0.8
        var titleHeight = width*0.5
        var playWidth = width*0.3
        
        if iPad{
            presentWidth = width*0.45
            presentHeight = width*0.3
            titleWidth = width*0.56
            titleHeight = width*0.35
            playWidth = width*0.2
        }
        
        utils.popItem(Duration: 0.9,Delay: 0.5, PopImage: self.present, PositionX: width*0.5, PositionY: height*0.5, Width: presentWidth, Height: presentHeight)
        utils.popItem(Duration: 0.6, Delay: 0.3, PopImage: self.passTitle, PositionX: width*0.5, PositionY: height*0.2, Width: titleWidth, Height: titleHeight)
        utils.popItem(Duration: 0.7, Delay: 1.0, PopImage: self.play, PositionX: width*0.5, PositionY: height*0.85, Width: playWidth, Height: playWidth)
        
        animateImages()
    }
    
    func addImages(){
        present = utils.addImage(item: present, frameX: width*0.5, frameY: height*0.5, frameW: 0, frameH: 0, imageName: "present", interactionEnabled: true)
        passTitle = utils.addImage(item: passTitle, frameX: width*0.5, frameY: height*0.8, frameW: 0, frameH: 0, imageName: "PASS", interactionEnabled: false)
        play = utils.addImage(item: play, frameX: width*0.5, frameY: height*0.85, frameW: 0, frameH: 0, imageName: "play", interactionEnabled: true)
        
        self.view.addSubview(present)
        self.view.addSubview(passTitle)
        self.view.addSubview(play)
    }
    func addGestures(){
        play.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(playTapped)))
        present.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(presentTapped)))
    }
    func animateImages(){
        Timer1 = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(callShake), userInfo: nil, repeats: true)
        
        utils.pulse(itemPulse: present, Duration: 1, Delay: 0)
        utils.miniPulse(itemPulse: passTitle, Duration: 4, Delay: 0)
        utils.pulse(itemPulse: play, Duration: 1.5, Delay: 0)
    }


    
    func createGradientLayer() {
        gradientLayer = utils.createGradientLayer()
        self.view.layer.addSublayer(gradientLayer)
        gradientTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(changeGradientPosition), userInfo: nil, repeats: true)
    }
    func changeGradientPosition(){
        utils.changeGradientPosition()
    }
    
    func presentTapped(){
        self.present.shake()
        shakeSoundPlayer.play()
    }
    func callShake(){
        self.present.shake()
        shakeSoundPlayer.play()
    }
    func playTapped(){
        Timer1.invalidate()
        self.play.layer.removeAllAnimations()
        shrinkPlayButton()
        
    }
    
    func shrinkPlayButton(){
        self.play.layer.removeAllAnimations()
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, animations: {
            self.play.transform = CGAffineTransform.identity.scaledBy(x: 0.4, y: 0.4)
            }, completion: { (finish) in
                self.growPlayButton()
        })
        
    }
    func growPlayButton(){
        self.play.layer.removeAllAnimations()
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.play.center = CGPoint(x: width*0.5, y: width*0.5)
            self.play.transform = CGAffineTransform.identity.scaledBy(x: 35, y: 35)
            }, completion: { (finish) in
                self.transitionToGame()
        })
        
    }
    
    func transitionToGame(){
        gradientTimer.invalidate()
        let setupViewController:SetupViewController = SetupViewController()
        self.present(setupViewController, animated: false, completion: nil)
    }
    
}




extension UIView {
    
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.13
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x:self.center.x - 10, y:self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x:self.center.x + 10,y: self.center.y))
        self.layer.add(animation, forKey: "position")
        
    }
    
    func startRotating(duration: Double = 1) {
        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) == nil {
            let animate = CABasicAnimation(keyPath: "transform.rotation")
            animate.duration = 1
            //animate.repeatCount = 3
            animate.autoreverses = true
            animate.repeatCount = Float.infinity
            animate.fromValue = 0.0
            animate.toValue = Float(M_PI * 2.0)
            self.layer.add(animate, forKey: kAnimationKey)
        }
    }
    func stopRotating() {
        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) != nil {
            self.layer.removeAnimation(forKey: kAnimationKey)
        }
    }
    
}
