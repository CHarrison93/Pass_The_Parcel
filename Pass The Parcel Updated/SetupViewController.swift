//
//  SetupViewController.swift
//  Pass The Parcel Updated
//
//  Created by Chris Harrison on 09/10/2016.
//  Copyright © 2016 Chris Harrison. All rights reserved.
//

import UIKit


class SetupViewController: UIViewController {
    
    let utils = Utils()

    
    var GameMode: UIImageView!
    var section1: UIImageView!
    var section2: UIImageView!
    
    var section1Text: UIImageView!
    var section2Text: UIImageView!
    
    var gradientModeLayer: CAGradientLayer!
    var gradientModeLayer2: CAGradientLayer!
    
    var sectionWidth: CGFloat!
    var sectionHeight: CGFloat!
    
    var gameType1: UIImageView!
    var gameType2: UIImageView!
    
    var continueButton: UIImageView!
    
    var selectionMade = false
    var parcelGame = true
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createGradientLayer()
        addImages()
        addGestures()
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
   
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        utils.popItem(Duration: 0.7,Delay: 0.5, PopImage: self.GameMode, PositionX: width*0.5, PositionY: width*0.15, Width: width*0.8, Height: width*0.08 )
        utils.popItem(Duration: 0.7,Delay: 0.7, PopImage: self.gameType1, PositionX: self.sectionWidth*0.55, PositionY: self.sectionHeight*0.7, Width: self.sectionWidth*0.57, Height: self.sectionWidth*0.2 )
        utils.popItem(Duration: 0.7,Delay: 0.7, PopImage: self.gameType2, PositionX: self.sectionWidth*0.55, PositionY: self.sectionHeight*0.7, Width: self.sectionWidth*0.65, Height: self.sectionWidth*0.2 )
        animateImages()

        
    }

    func addImages(){
        var s1W = width*0.9
        var s1H = width*0.55
        if iPad{
            s1W = width*0.65
            s1H = width*0.4
        }
        GameMode = utils.addImage(item: GameMode, frameX: width*0.5, frameY: height*0.08, frameW: 0, frameH: 0, imageName: "GameMode", interactionEnabled:true)
        self.view.addSubview(GameMode)
        
        section1 = utils.addSection(x: width*0.5, y: height*0.3, w: s1W, h: s1H)
        self.view.addSubview(section1)
        
        gradientModeLayer = utils.addGradientToSection(item: gradientModeLayer)
        section1.layer.addSublayer(gradientModeLayer)
        
        sectionWidth = section1.bounds.width
        sectionHeight = section1.bounds.height
        
        section1Text = utils.addImage(item: section1Text, frameX: sectionWidth*0.385, frameY: sectionHeight*0.3, frameW: sectionWidth*0.7, frameH: sectionWidth*0.135, imageName: "NoParcel", interactionEnabled: true)
        section1.addSubview(section1Text)
        
        gameType1 = utils.addImage(item: gameType1, frameX: sectionWidth*0.63, frameY: sectionWidth*0.7, frameW: 0, frameH: 0, imageName: "GameType1", interactionEnabled: true)
        section1.addSubview(gameType1)
        
        section2 = utils.addSection(x: width*0.5, y: height*0.7, w: s1W, h: s1H)
        self.view.addSubview(section2)
        
        gradientModeLayer2 = utils.addGradientToSection(item: gradientModeLayer2)
        section2.layer.addSublayer(gradientModeLayer2)
        
        section2Text = utils.addImage(item: section2Text, frameX: sectionWidth*0.45, frameY: sectionHeight*0.3, frameW: sectionWidth*0.8, frameH: sectionWidth*0.154, imageName: "HaveParcel", interactionEnabled: true)
        section2.addSubview(section2Text)
        
        gameType2 = utils.addImage(item: gameType2, frameX: sectionWidth*0.6, frameY: sectionHeight*0.7, frameW: 0, frameH: 0, imageName: "GameType2", interactionEnabled: true)
        section2.addSubview(gameType2)
        
        continueButton = utils.addImage(item: continueButton, frameX: width*0.5, frameY: height*0.9, frameW: 0, frameH: 0, imageName: "CONTINUE", interactionEnabled: true)
        self.view.addSubview(continueButton)
        
    }
    
    func addGestures(){
        
        
        section1.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(section1Pressed)))
        section1Text.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(section1Pressed)))
        gameType1.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(section1Pressed)))
        
        section2.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(section2Pressed)))
        section2Text.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(section2Pressed)))
        gameType2.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(section2Pressed)))
        
        continueButton.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(shrinkAll)))

    }
    
    func section1Pressed(){
        UIView.animate(withDuration: 0.8, delay: 0, options: UIViewAnimationOptions.autoreverse, animations: {
            self.gradientModeLayer.colors = [UIColor(red: 20.0/255, green: 220.0/255, blue: 80.0/255, alpha: 1.0).cgColor, UIColor(red: 20.0/255, green: 240.0/255, blue: 90.0/255, alpha: 0.9).cgColor]
            self.gradientModeLayer2.colors = [UIColor(red: 1.0/255, green: 215.0/255, blue: 225.0/255, alpha: 1.0).cgColor, UIColor(red: 200.0/255, green: 250.0/255, blue: 245.0/255, alpha: 0.9).cgColor]
            }, completion:nil)
        print("section1Pressed")
        if (!selectionMade){
            utils.popItem(Duration: 0.7,Delay: 0.2, PopImage: self.continueButton, PositionX: width*0.5, PositionY: height*0.92, Width: width*0.6, Height: width*0.118 )
            utils.bigPulse(itemPulse: continueButton, Duration: 0.6, Delay: 0)
            selectionMade = true
            parcelGame = false
        }
        parcelGame = false
        defaults.set(parcelGame, forKey: "ParcelWithList")
        
        
    }
    func section2Pressed(){
        print("section2Pressed")
        UIView.animate(withDuration: 0.8, delay: 0, options: UIViewAnimationOptions.autoreverse, animations: {
            self.gradientModeLayer2.colors = [UIColor(red: 20.0/255, green: 220.0/255, blue: 80.0/255, alpha: 1.0).cgColor, UIColor(red: 20.0/255, green: 240.0/255, blue: 90.0/255, alpha: 0.9).cgColor]
            self.gradientModeLayer.colors = [UIColor(red: 1.0/255, green: 215.0/255, blue: 225.0/255, alpha: 1.0).cgColor, UIColor(red: 200.0/255, green: 250.0/255, blue: 245.0/255, alpha: 0.9).cgColor]
            }, completion: nil)
        if (!selectionMade){
            utils.popItem(Duration: 0.7,Delay: 0.2, PopImage: self.continueButton, PositionX: width*0.5, PositionY: height*0.92, Width: width*0.6, Height: width*0.118 )
            utils.bigPulse(itemPulse: continueButton, Duration: 0.6, Delay: 0)
            selectionMade = true
            parcelGame = true
        }
        parcelGame = true
        defaults.set(parcelGame, forKey: "ParcelWithList")
    }
    
    func shrinkAll(){
        
        self.view.layer.removeAllAnimations()
        self.section1.layer.removeAllAnimations()
        self.section2.layer.removeAllAnimations()
        self.continueButton.removeFromSuperview()
        self.GameMode.layer.removeAllAnimations()
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, animations: {
            
            self.continueButton.transform = CGAffineTransform.identity.translatedBy(x: -1000, y: 0)
            self.GameMode.transform = CGAffineTransform.identity.translatedBy(x: -1000, y: 0)
            self.section1.transform = CGAffineTransform.identity.translatedBy(x: -1000, y: 0)
            self.section2.transform = CGAffineTransform.identity.translatedBy(x: -1000, y: 0)
            self.section1Text.transform = CGAffineTransform.identity.translatedBy(x: -1000, y: 0)
            self.section2Text.transform = CGAffineTransform.identity.translatedBy(x: -1000, y: 0)
            self.gameType1.transform = CGAffineTransform.identity.translatedBy(x: -1000, y: 0)
            self.gameType2.transform = CGAffineTransform.identity.translatedBy(x: -1000, y: 0)
            }, completion: { (finish) in
                self.transitionToNext()
        })
    }
    
    func transitionToNext(){
        gradientTimer.invalidate()
        if (parcelGame){
            let musicSelectionViewController:MusicSelectionViewController = MusicSelectionViewController()
            self.present(musicSelectionViewController, animated: false, completion: nil)
        }
        else{
            let noParcelGameViewController:NoParcelGameViewController = NoParcelGameViewController()
            
            self.present(noParcelGameViewController, animated: false, completion: nil)
        }
    }
    
    
    func animateImages(){
        
        utils.miniPulse(itemPulse: GameMode, Duration: 3.5, Delay: 0)
        utils.miniPulse(itemPulse: section1Text, Duration: 4, Delay: 0.5)
        utils.miniPulse(itemPulse: section2Text, Duration: 4, Delay: 0.5)
        
        utils.pulse(itemPulse: gameType1, Duration: 1, Delay: 0)
        utils.pulse(itemPulse: gameType2, Duration: 1, Delay: 0)
        
    }
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createGradientLayer() {
        gradientLayer = utils.createGradientLayer()
        self.view.layer.addSublayer(gradientLayer)
        gradientTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(changeGradientPosition), userInfo: nil, repeats: true)
    }
    func changeGradientPosition(){
        utils.changeGradientPosition()
    }
    

    
    
}
