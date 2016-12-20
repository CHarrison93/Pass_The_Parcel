//
//  NoParcelGameViewController.swift
//  Pass The Parcel Updated
//
//  Created by Chris Harrison on 17/10/2016.
//  Copyright © 2016 Chris Harrison. All rights reserved.
//

import UIKit

class NoParcelGameViewController: UIViewController, UITextViewDelegate {
    
    let utils = Utils()
    
    
    var backButton: UIImageView!
    var homeButton: UIImageView!
    
    var titleText: UIImageView!
    var parcelListBox: UITextView!
    var randomText: UIImageView!
    var randomTickBox: UIImageView!
    var randomTick: UIImageView!
    var continueToMusic: UIImageView!
    
    var isRandom = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addImages()
        addGestures()
        addBackButton()
        addHomeButton()
        
        self.parcelListBox.delegate = self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("No parcel")
        
        //Setup View
        self.view.backgroundColor = UIColor.white
        
        
        //Setup Gradient
        createGradientLayer()
    }
    override func viewDidAppear(_ animated: Bool) {
        
        var tY = height*0.2
        var tW = width*0.8
        var tH = width*0.223
        var bPY = height*0.38
        var rY = height*0.5
        
        if iPad{
            tY = height*0.25
            tW = width*0.64
            tH = width*0.1784
            bPY = height*0.45
            rY = height*0.65
        }
        
        utils.popItem(Duration: 0.7,Delay: 0, PopImage: self.titleText, PositionX: width*0.5, PositionY: tY, Width: tW, Height: tH )
        utils.popTextBox(Duration: 0.7,Delay: 0.2, PopImage: self.parcelListBox, PositionX: width*0.5, PositionY: bPY, Width: width*0.95, Height: width*0.3 )
        utils.popItem(Duration: 0.7,Delay: 0, PopImage: self.randomText, PositionX: width*0.43, PositionY: rY, Width: width*0.7, Height: width*0.074 )
        utils.popItem(Duration: 0.7,Delay: 0, PopImage: self.randomTickBox, PositionX: width*0.88, PositionY: rY, Width: width*0.074, Height: width*0.074 )
        utils.popItem(Duration: 0.7,Delay: 0, PopImage: self.backButton, PositionX: width*0.1, PositionY: height*0.08, Width: width*0.1, Height: width*0.1 )
        utils.popItem(Duration: 0.7,Delay: 0, PopImage: self.continueToMusic, PositionX: width*0.5, PositionY: height*0.9, Width: width*0.75, Height: width*0.164 )
        
        callPulses()
        
        if (defaults.bool(forKey: "Random")){
            isRandom = true
            var tickedPos = height*0.5
            if iPad{
                tickedPos = height*0.65
            }
            utils.popItem(Duration: 0.5,Delay: 0.1, PopImage: self.randomTick, PositionX: width*0.88, PositionY: tickedPos, Width: width*0.074, Height: width*0.074 )
        }
    }
    
    func addImages(){
        
        titleText = utils.addImage(item: titleText, frameX: width*0.5, frameY: height*0.15, frameW: 0, frameH: 0, imageName: "NoParcelSetup", interactionEnabled: true)
        self.view.addSubview(titleText)
        
        //add Text Box
        parcelListBox = UITextView(frame:CGRect(x: width*0.5, y: height*0.08 + height*0.3, width: 0, height: 0))
        parcelListBox.center = CGPoint(x: width*0.5, y: height*0.08 + height*0.3)
        parcelListBox.layer.cornerRadius = 5.0
        parcelListBox.layer.borderColor = UIColor.black.cgColor
        parcelListBox.layer.borderWidth = 2.5
        parcelListBox.backgroundColor = UIColor.white
        parcelListBox.textColor = UIColor.black
        parcelListBox.isEditable = true
        parcelListBox.text = defaults.string(forKey: "ParcelList")
        self.view.addSubview(parcelListBox)
        
        
        randomText = utils.addImage(item: randomText, frameX: width*0.45, frameY: height*0.5, frameW: 0, frameH: 0, imageName: "Randomise", interactionEnabled: true)
        self.view.addSubview(randomText)
        
        
        randomTickBox = UIImageView(frame:CGRect(x: width*0.85, y: height*0.5, width: 0, height: 0))
        randomTickBox.backgroundColor = UIColor.red.withAlphaComponent(0.4)
        randomTickBox.center = CGPoint(x: width*0.85, y: height*0.5)
        randomTickBox.isUserInteractionEnabled = true
        randomTickBox.layer.borderWidth = 2.5
        randomTickBox.layer.borderColor = UIColor.black.cgColor
        randomTickBox.layer.cornerRadius = 5
        self.view.addSubview(randomTickBox)
        
        //Random Tick Box Tick
        var tickPos = height*0.5
        if iPad{
            tickPos = height*0.65
        }
        
        randomTick = utils.addImage(item: randomTick, frameX: width*0.85, frameY: tickPos, frameW: 0, frameH: 0, imageName: "checked", interactionEnabled: true)
        self.view.addSubview(randomTick)
        
       continueToMusic = utils.addImage(item: continueToMusic, frameX: width*0.5, frameY: height*0.9, frameW: 0, frameH: 0, imageName: "ContinueToMusic", interactionEnabled: true)
        self.view.addSubview(continueToMusic)
        
    }
    
    func addGestures(){
        
        randomTickBox.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(randomTickBoxPressed)))
        randomTick.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(randomTickBoxPressed)))
        randomText.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(randomTickBoxPressed)))
        continueToMusic.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(continueButtonPressed)))
        
    }
    
    func callPulses(){
        utils.miniPulse(itemPulse: titleText, Duration: 3.5, Delay: 0)
        utils.miniPulse(itemPulse: randomText, Duration: 2.5, Delay: 0)
        utils.miniPulse(itemPulse: randomTickBox, Duration: 2.5, Delay: 0)
        utils.pulse(itemPulse: continueToMusic, Duration: 1.5, Delay: 0)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        defaults.set(parcelListBox.text, forKey: "ParcelList")
    }
    
    func randomTickBoxPressed(){
        var tickLocation = height*0.5
        if iPad{
            tickLocation = height*0.65
        }
        print("Tick Box Pressed")
        if (!isRandom){
            isRandom = true
            utils.popItem(Duration: 0.5,Delay: 0.1, PopImage: self.randomTick, PositionX: width*0.88, PositionY: tickLocation, Width: width*0.074, Height: width*0.074 )
            defaults.set(true, forKey: "Random")
            
        }
        else{
            isRandom = false
            utils.popItem(Duration: 0.5,Delay: 0.1, PopImage: self.randomTick, PositionX: width*0.88, PositionY: tickLocation, Width: 0, Height: 0 )
            defaults.set(false, forKey: "Random")
        }
    }
    
    func continueButtonPressed(){
        swipeAllLeft()
    }

    
    func createGradientLayer() {
        gradientLayer = utils.createGradientLayer()
        self.view.layer.addSublayer(gradientLayer)
        gradientTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(changeGradientPosition), userInfo: nil, repeats: true)
    }
    func changeGradientPosition(){
        utils.changeGradientPosition()
    }
    
    func addBackButton(){
        
        backButton = utils.addImage(item: backButton, frameX: width*0.1, frameY: height*0.08, frameW: width*0.1, frameH: width*0.1, imageName: "back", interactionEnabled: true)
        self.view.addSubview(backButton)
        backButton.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(swipeAllRight)))
    }
    
    func addHomeButton(){
        
    }
    
    func swipeAllRight(){
        titleText.layer.removeAllAnimations()
        randomText.layer.removeAllAnimations()
        randomTickBox.layer.removeAllAnimations()
        continueToMusic.layer.removeAllAnimations()
        continueToMusic.removeFromSuperview()
        randomTickBox.removeFromSuperview()
        randomText.removeFromSuperview()
        
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, animations: {
            
            self.backButton.transform = CGAffineTransform.identity.translatedBy(x: 1000, y: 0)
            self.titleText.transform = CGAffineTransform.identity.translatedBy(x: 1000, y: 0)
            self.parcelListBox.transform = CGAffineTransform.identity.translatedBy(x: 1000, y: 0)
            self.randomTick.transform = CGAffineTransform.identity.translatedBy(x: 1000, y: 0)
            self.randomTickBox.transform = CGAffineTransform.identity.translatedBy(x: 1000, y: 0)
            self.randomText.transform = CGAffineTransform.identity.translatedBy(x: 1000, y: 0)
            }, completion: { (finish) in
                self.removeAllFromSuperview()
                self.goBackViewController()
        })
    }
    
    func swipeAllLeft(){
        titleText.layer.removeAllAnimations()
        randomText.layer.removeAllAnimations()
        randomTickBox.layer.removeAllAnimations()
        continueToMusic.layer.removeAllAnimations()
        continueToMusic.removeFromSuperview()
        randomTickBox.removeFromSuperview()
        
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, animations: {
            
            self.backButton.transform = CGAffineTransform.identity.translatedBy(x: -1000, y: 0)
            self.titleText.transform = CGAffineTransform.identity.translatedBy(x: -1000, y: 0)
            self.parcelListBox.transform = CGAffineTransform.identity.translatedBy(x: -1000, y: 0)
            self.randomTick.transform = CGAffineTransform.identity.translatedBy(x: -1000, y: 0)
            self.randomTickBox.transform = CGAffineTransform.identity.translatedBy(x: -1000, y: 0)
            self.randomText.transform = CGAffineTransform.identity.translatedBy(x: -1000, y: 0)
            }, completion: { (finish) in
                self.removeAllFromSuperview()
                self.goMusicViewController()
                
        })
        
    }
    
    func removeAllFromSuperview(){
        self.backButton.removeFromSuperview()
        self.titleText.removeFromSuperview()
        self.randomText.removeFromSuperview()
        //self.randomTickBox.removeFromSuperview()
        self.randomTick.removeFromSuperview()
        self.parcelListBox.removeFromSuperview()
    }

    
    func goBackViewController(){
        gradientTimer.invalidate()
        
        let setupViewController:SetupViewController = SetupViewController()
        self.present(setupViewController, animated: false, completion: nil)
    }
    func goHomeViewController(){
        gradientTimer.invalidate()
        
    }
    func goMusicViewController(){
        gradientTimer.invalidate()
        let musicSelectionViewController:MusicSelectionViewController = MusicSelectionViewController()
        self.present(musicSelectionViewController, animated: false, completion: nil)
    }
    
    
}

