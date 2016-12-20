//
//  MusicSelectionViewController.swift
//  Pass The Parcel Updated
//
//  Created by Chris Harrison on 22/10/2016.
//  Copyright © 2016 Chris Harrison. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

var myMusicPlayer: MPMusicPlayerController = MPMusicPlayerController()
let utils = Utils()
let music = Music()

class MusicSelectionViewController: UIViewController, MPMediaPickerControllerDelegate {
    
    var SystemPlaylist = [String]()
    
    
    var backButton: UIImageView!
    var titleText: UIImageView!
    
    var section1: UIImageView!
    var section2: UIImageView!

    var gradientModeLayer: CAGradientLayer!
    var gradientModeLayer2: CAGradientLayer!
    
    var libraryMusicText: UIImageView!
    var DefaultMusicText: UIImageView!
    var musicIcon: UIImageView!
    var defaultMusicIcon: UIImageView!
    
    var musicSelected: UIImageView!
    var musicSelectedText: UILabel!
    var noMusicSelected: UIImageView!
    
     var continueButton: UIImageView!
    
    var mediaPicker: MPMediaPickerController?
    
    var picker: MPMediaPickerController!
    
    var sectionWidth: CGFloat!
    var sectionHeight: CGFloat!
    
    var musicChosen = false
    
    
    var firstAppearance = true
    
    override func viewWillAppear(_ animated: Bool) {
        if firstAppearance == true{
            firstAppearance = false
            super.viewWillAppear(animated)
            addImages()
            addGestures()
            addBackButton()
            addHomeButton()
            BackgroundMusicPlayer.play()
            if #available(iOS 10.0, *) {
                BackgroundMusicPlayer.setVolume(0.4, fadeDuration: 1)
            } else {
                // Fallback on earlier versions
            }
            
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Music Selection")
        
        //Setup View
        self.view.backgroundColor = UIColor.white
        
        //Setup Gradient
        createGradientLayer()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var mIW = width*0.25
        var mIX = width*0.25
        var nMW = width*0.4
        var nMH = width*0.1515
        
        if iPad{
            mIW = width*0.22
            mIX = width*0.32
            nMW = width*0.3
            nMH = width*0.1136
        }
        
        utils.popItem(Duration: 0.7,Delay: 0, PopImage: self.titleText, PositionX: width*0.5, PositionY: height*0.1, Width: width*0.6, Height: width*0.132 )
        utils.popItem(Duration: 0.7,Delay: 0.2, PopImage: self.libraryMusicText, PositionX: width*0.5, PositionY: height*0.25, Width: width*0.6, Height: width*0.03512 )
        utils.popItem(Duration: 0.7,Delay: 0.2, PopImage: self.DefaultMusicText, PositionX: width*0.5, PositionY: height*0.6, Width: width*0.461, Height: width*0.03512 )
        utils.popItem(Duration: 0.7,Delay: 0.2, PopImage: self.musicIcon, PositionX: mIX, PositionY: height*0.35, Width: mIW, Height: mIW )
        utils.popItem(Duration: 0.7,Delay: 0.2, PopImage: self.noMusicSelected, PositionX: width*0.65, PositionY: height*0.35, Width: nMW, Height: nMH )
        utils.popItem(Duration: 0.7,Delay: 0.2, PopImage: self.defaultMusicIcon, PositionX: width*0.5, PositionY: height*0.73, Width: width*0.3, Height: width*0.3 )
        
        callPulses()
        
    }
    
    func callPulses(){
        utils.miniPulse(itemPulse: titleText, Duration: 2.5, Delay: 0)
        utils.miniPulse(itemPulse: libraryMusicText, Duration: 3.5, Delay: 0)
        utils.miniPulse(itemPulse: DefaultMusicText, Duration: 3.5, Delay: 0)
        utils.miniPulse(itemPulse: musicIcon, Duration: 3, Delay: 0)
        utils.miniPulse(itemPulse: defaultMusicIcon, Duration: 3, Delay: 0)
    }
    
    func addImages(){
        
        titleText = utils.addImage(item: titleText, frameX: 0.5, frameY: 0.1, frameW: 0, frameH: 0, imageName: "MusicTitle", interactionEnabled: true)
        self.view.addSubview(titleText)
        
        var s1W = width*0.9
        var s1H = width*0.55
        if iPad{
            s1W = width*0.7
            s1H = width*0.4
        }
        
        
        section1 = utils.addSection(x: width*0.5, y: height*0.35, w: s1W, h: s1H)
        self.view.addSubview(section1)
        
        gradientModeLayer = utils.addGradientToSection(item: gradientModeLayer)
        section1.layer.addSublayer(gradientModeLayer)
        
        sectionWidth = section1.bounds.width
        sectionHeight = section1.bounds.height
        
        section2 = utils.addSection(x: width*0.5, y: height*0.7, w: s1W, h: s1H)
        self.view.addSubview(section2)
        
        gradientModeLayer2 = utils.addGradientToSection(item: gradientModeLayer2)
        section2.layer.addSublayer(gradientModeLayer2)
        
        libraryMusicText = utils.addImage(item: libraryMusicText, frameX: width*0.5, frameY: height*0.3, frameW: 0, frameH: 0, imageName: "LibraryMusic", interactionEnabled: true)
        self.view.addSubview(libraryMusicText)
        
        musicIcon = utils.addImage(item: musicIcon, frameX: width*0.25, frameY: height*0.42, frameW: 0, frameH: 0, imageName: "musicIcon", interactionEnabled: true)
        self.view.addSubview(musicIcon)
        
        defaultMusicIcon = utils.addImage(item: defaultMusicIcon, frameX: width*0.25, frameY: height*0.42, frameW: 0, frameH: 0, imageName: "DefaultMusicIcon", interactionEnabled: true)
        self.view.addSubview(defaultMusicIcon)
        
        DefaultMusicText = utils.addImage(item: DefaultMusicText, frameX: width*0.5, frameY: height*0.65, frameW: 0, frameH: 0, imageName: "DefaultMusic", interactionEnabled: true)
        self.view.addSubview(DefaultMusicText)
        
        continueButton = utils.addImage(item: continueButton, frameX: width*0.5, frameY: height*0.9, frameW: 0, frameH: 0, imageName: "CONTINUE", interactionEnabled: true)
        self.view.addSubview(continueButton)
        
        musicSelected = utils.addImage(item: musicSelected, frameX: width*0.5, frameY: height*0.4, frameW: 0, frameH: 0, imageName: "MusicSelected", interactionEnabled: true)
        self.view.addSubview(musicSelected)
        
        musicSelectedText = UILabel(frame: CGRect(x: 0, y: 0, width: width*0.4, height: height*0.2))
        musicSelectedText.center = CGPoint(x: width*0.65, y: height*0.35)
        musicSelectedText.textAlignment = .center
        musicSelectedText.text = ""
        musicSelectedText.numberOfLines = 3
        self.view.addSubview(musicSelectedText)
        musicSelectedText.isHidden = true
        
        noMusicSelected = utils.addImage(item: noMusicSelected, frameX: width*0.65, frameY: height*0.45, frameW: 0, frameH: 0, imageName: "NoMusicSelected", interactionEnabled: true)
        self.view.addSubview(noMusicSelected)
        
        
        
        
    }
    
    func addGestures(){
        
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .authorized {
                self.section1.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(self.libraryMusicPressed)))
                self.libraryMusicText.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(self.libraryMusicPressed)))
                self.noMusicSelected.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(self.libraryMusicPressed)))
                self.section2.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(self.section2Pressed)))
                self.DefaultMusicText.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(self.section2Pressed)))
                self.defaultMusicIcon.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(self.section2Pressed)))
                self.continueButton.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(self.swipeAllLeft)))
            }
        }
        musicIcon.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(libraryMusicPressed)))
        
        

    }
    
    func section2Pressed(){
        
        utils.gradientToGreen(ToGreen: self.gradientModeLayer2, ToRed: self.gradientModeLayer)
        defaults.set(true, forKey: "DefaultMusic")
        showContinueButton()
    }
    
    func libraryMusicPressed(){
        myMusicPlayer = MPMusicPlayerController()
        displayMediaPickerAndPlayItem()
    }
    
    func displayMediaPickerAndPlayItem(){
        let mediaPicker: MPMediaPickerController = MPMediaPickerController.self(mediaTypes:MPMediaType.music)
        mediaPicker.allowsPickingMultipleItems = true
        mediaPicker.delegate = self
        self.present(mediaPicker, animated: true, completion: nil)
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        self.dismiss(animated: true, completion: nil)
        print("Nothing Chosen")
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        myMusicPlayer = MPMusicPlayerController()
        
        let player2 = myMusicPlayer
        player2.beginGeneratingPlaybackNotifications()
        player2.setQueue(with: mediaItemCollection)
        player2.prepareToPlay()
        player2.repeatMode = MPMusicRepeatMode.all
        
        self.dismiss(animated: true, completion: nil)
        if mediaItemCollection.count > 0{
            print("\(mediaItemCollection.count) songs queued to play")
            showContinueButton()
            utils.popItem(Duration: 0.7,Delay: 0.2, PopImage: self.musicSelected, PositionX: width*0.65, PositionY: height*0.3, Width: width*0.4, Height: width*0.07 )
            musicSelectedText.isHidden = false
            musicSelectedText.textColor = UIColor.white
            noMusicSelected.isHidden = true
            let nowPlaying = myMusicPlayer.nowPlayingItem
            let currentSong = nowPlaying?.title
            musicSelectedText.text = currentSong
            musicChosen = true
            defaults.set(false, forKey: "DefaultMusic")
            }
        else{
                print("No items chosen")
            }
            utils.gradientToGreen(ToGreen: self.gradientModeLayer, ToRed: self.gradientModeLayer2)
        
            print(mediaItemCollection.items)
        
            showContinueButton()
        
    }
    
    func showContinueButton(){
        utils.popItem(Duration: 0.7,Delay: 0.2, PopImage: self.continueButton, PositionX: width*0.5, PositionY: height*0.92, Width: width*0.6, Height: width*0.118 )
        utils.bigPulse(itemPulse: continueButton, Duration: 0.6, Delay: 0)
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
        
        musicSelectedText.isHidden = true
        continueButton.isHidden = true
        titleText.layer.removeAllAnimations()
        backButton.layer.removeAllAnimations()
        section1.layer.removeAllAnimations()
        section2.layer.removeAllAnimations()
        libraryMusicText.layer.removeAllAnimations()
        DefaultMusicText.layer.removeAllAnimations()
        musicIcon.layer.removeAllAnimations()
        defaultMusicIcon.layer.removeAllAnimations()
        musicSelected.layer.removeAllAnimations()
        noMusicSelected.layer.removeAllAnimations()
        musicSelectedText.removeFromSuperview()
        
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, animations: {
            
            let shiftRightTransform = CGAffineTransform.identity.translatedBy(x: 1000, y: 0)
            
            self.backButton.transform = shiftRightTransform
            self.titleText.transform = shiftRightTransform
            self.section1.transform = shiftRightTransform
            self.section2.transform = shiftRightTransform
            self.libraryMusicText.transform = shiftRightTransform
            self.DefaultMusicText.transform = shiftRightTransform
            self.musicIcon.transform = shiftRightTransform
            self.defaultMusicIcon.transform = shiftRightTransform
            self.musicSelected.transform = shiftRightTransform
            self.noMusicSelected.transform = shiftRightTransform
            self.continueButton.transform = shiftRightTransform
            self.musicSelected.transform = shiftRightTransform
            }, completion: { (finish) in
                self.goBackViewController()
        })
    }
    
    func swipeAllLeft(){
        musicSelectedText.isHidden = true
        continueButton.isHidden = true
        titleText.isHidden = true
        titleText.layer.removeAllAnimations()
        backButton.layer.removeAllAnimations()
        section1.layer.removeAllAnimations()
        section2.layer.removeAllAnimations()
        libraryMusicText.layer.removeAllAnimations()
        DefaultMusicText.layer.removeAllAnimations()
        musicIcon.layer.removeAllAnimations()
        defaultMusicIcon.layer.removeAllAnimations()
        musicSelected.layer.removeAllAnimations()
        noMusicSelected.layer.removeAllAnimations()
        musicSelectedText.removeFromSuperview()
        
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, animations: {
            
            let shiftLetftTransform = CGAffineTransform.identity.translatedBy(x: -1000, y: 0)
            
            self.backButton.transform = shiftLetftTransform
            self.titleText.transform = shiftLetftTransform
            self.section1.transform = shiftLetftTransform
            self.section2.transform = shiftLetftTransform
            self.libraryMusicText.transform = shiftLetftTransform
            self.DefaultMusicText.transform = shiftLetftTransform
            self.musicIcon.transform = shiftLetftTransform
            self.defaultMusicIcon.transform = shiftLetftTransform
            self.musicSelected.transform = shiftLetftTransform
            self.noMusicSelected.transform = shiftLetftTransform
            self.continueButton.transform = shiftLetftTransform
            self.musicSelected.transform = shiftLetftTransform
        }, completion: { (finish) in
            self.goGameViewController()
            
        })
        
    }
    
    func goBackViewController(){
        gradientTimer.invalidate()
        
        let setupViewController:SetupViewController = SetupViewController()
        self.present(setupViewController, animated: false, completion: nil)
    }
    func goHomeViewController(){
        gradientTimer.invalidate()
        
    }
    func goGameViewController(){
        gradientTimer.invalidate()
        let gameViewController:GameViewController = GameViewController()
        self.present(gameViewController, animated: false, completion: nil)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
