//
//  GameViewController.swift
//  Pass The Parcel Updated
//
//  Created by Chris Harrison on 07/11/2016.
//  Copyright © 2016 Chris Harrison. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation
import JSSAlertView
import Foundation



class GameViewController: UIViewController {

    let utils = Utils()
    
    var backButton: UIImageView!
    
    var firstAppearance = true
    var timer: Timer!
    
    var albumArtwork: UIImageView!
    var songTitle: UILabel!
    var artist: UILabel!
    var album: UILabel!
    
    var nextButton: UIImageView!
    var previousButton: UIImageView!
    
    var playButton: UIImageView!
    var stopButton: UIImageView!
    
    
    var customIcon:UIImage!
    var customColor:UIColor!
    
    var itemList = [String]()
    var itemListPosition = 0
    var itemListLength = 0
    
    var randomList = [String]()
    var currentTrackIndex = 0
    var stillPlaying = false
    
    var player: AVAudioPlayer?

    override func viewWillAppear(_ animated: Bool) {
        if firstAppearance == true{
            firstAppearance = false
            super.viewWillAppear(animated)
            addImages()
            addGestures()
            addBackButton()
            addHomeButton()
            if !defaults.bool(forKey: "DefaultMusic"){
                myMusicPlayer.beginGeneratingPlaybackNotifications()
            }
            addObservers()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if defaults.bool(forKey: "DefaultMusic"){
            defaultMusic()
        }
        //Setup View
        self.view.backgroundColor = UIColor.white
        
        customIcon = UIImage(named: "gift")
        customIcon = customIcon.scaleImageToSize(newSize: CGSize(width: width*0.18, height: width*0.18))
        customColor = UIColor(red: 100/255, green: 230/255, blue: 255/255, alpha: 1.0)
        
        createGradientLayer()
        
        if #available(iOS 10.0, *) {
            BackgroundMusicPlayer.setVolume(0, fadeDuration: 1)
        } else {
            BackgroundMusicPlayer.pause()
        }
        
        
        itemList = defaults.string(forKey: "ParcelList")!.components(separatedBy: ",")
        itemListLength = itemList.count
        if (defaults.bool(forKey: "Random")){
            randomiseList()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        //pop stuff
        
        utils.popItem(Duration: 0.7,Delay: 0.2, PopImage: self.previousButton, PositionX: width*0.15, PositionY: height*0.93, Width: width*0.13, Height: width*0.13 )
        utils.popItem(Duration: 0.7,Delay: 0.2, PopImage: self.nextButton, PositionX: width*0.85, PositionY: height*0.93, Width: width*0.13, Height: width*0.13 )
        utils.popItem(Duration: 0.7,Delay: 0.2, PopImage: self.playButton, PositionX: width*0.5, PositionY: height*0.8, Width: width*0.25, Height: width*0.25 )

        callPulses()
    }
    
    func defaultMusic(){
        if (player != nil) {
            player = nil
        }
        let path = Bundle.main.path(forResource: music.songs[currentTrackIndex], ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            player = sound
            player?.prepareToPlay()

        } catch {
            // couldn't load file :(
        }
    }
    func nextDefault(){
        currentTrackIndex += 1
        if currentTrackIndex == music.songs.count{
            currentTrackIndex = 0
        }
        let path = Bundle.main.path(forResource: music.songs[currentTrackIndex], ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            player = sound
            if (stillPlaying){
               player?.play()
            }else{
               player?.prepareToPlay()
            }
            
        } catch {
            // couldn't load file :(
        }
        
        
    }
    func previousDefault(){
        currentTrackIndex -= 1
        if currentTrackIndex < 0{
            currentTrackIndex = music.songs.count-1
        }
        let path = Bundle.main.path(forResource: music.songs[currentTrackIndex], ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            player = sound
            if (stillPlaying){
                player?.play()
            }else{
                player?.prepareToPlay()
            }
            
        } catch {
            // couldn't load file :(
        }
    }
    
    
    func defaultFinished(){
        currentTrackIndex += 1
        if currentTrackIndex == music.songs.count{
            currentTrackIndex = 0
        }
        let path = Bundle.main.path(forResource: music.songs[currentTrackIndex], ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            player = sound
            player?.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    func callPulses(){
        
        utils.miniPulse(itemPulse: albumArtwork, Duration: 2.5, Delay: 0.5)
        utils.miniPulse(itemPulse: nextButton, Duration: 1.5, Delay: 0.5)
        utils.miniPulse(itemPulse: previousButton, Duration: 1.5, Delay: 0.5)
        
    }
    
    func addImages(){
        
        albumArtwork = UIImageView(frame: CGRect(x:width*0.5, y:height*0.4, width:width*0.5, height:width*0.5))
        albumArtwork.layer.masksToBounds = false
        albumArtwork.layer.cornerRadius = albumArtwork.frame.size.width/2
        albumArtwork.center = CGPoint(x: width*0.5, y: height*0.4)
        albumArtwork.clipsToBounds = true
        
        if defaults.bool(forKey: "DefaultMusic"){
            albumArtwork.image = (UIImage(named: "Vinyl"))
        }else{
            albumArtwork.layer.borderWidth = 1.0
            albumArtwork.layer.borderColor = UIColor.white.cgColor
            let nowPlaying = myMusicPlayer.nowPlayingItem
            let artworkImage = nowPlaying?.artwork?.image(at: CGSize(width: width*0.5, height: width*0.5))
            albumArtwork.image = artworkImage
        }
        
        
        if defaults.bool(forKey: "DefaultMusic"){
            
        }
        else{
            let nowPlaying = myMusicPlayer.nowPlayingItem
            let songName = nowPlaying?.title
            let artistName = nowPlaying?.artist
            let albumName = nowPlaying?.albumTitle
            songTitle = UILabel(frame: CGRect(x: width*0.5, y: height*0.6, width: width*0.7, height: height*0.1))
            songTitle.center = CGPoint(x: width*0.5, y: height*0.58)
            songTitle.textAlignment = .center
            songTitle.text = ""
            songTitle.textColor = UIColor.white
            songTitle.numberOfLines = 3
            songTitle.text = songName
            self.view.addSubview(songTitle)
            artist = UILabel(frame: CGRect(x: width*0.5, y: height*0.61, width: width*0.7, height: height*0.1))
            artist.center = CGPoint(x: width*0.5, y: height*0.61)
            artist.textAlignment = .center
            artist.text = ""
            artist.textColor = UIColor.white
            artist.numberOfLines = 3
            artist.text = artistName
            self.view.addSubview(artist)
            album = UILabel(frame: CGRect(x: width*0.5, y: height*0.66, width: width*0.7, height: height*0.1))
            album.center = CGPoint(x: width*0.5, y: height*0.64)
            album.textAlignment = .center
            album.text = ""
            album.textColor = UIColor.white
            album.numberOfLines = 3
            album.text = albumName
            self.view.addSubview(album)
            
            
        }
        self.view.addSubview(albumArtwork)
        
        
        nextButton = utils.addImage(item: nextButton, frameX: width*0.85, frameY: height*0.9, frameW: 0, frameH: 0, imageName: "next", interactionEnabled: true)
        self.view.addSubview(nextButton)
        
        previousButton = utils.addImage(item: previousButton, frameX: width*0.15, frameY: height*0.9, frameW: 0, frameH: 0, imageName: "previous", interactionEnabled: true)
        self.view.addSubview(previousButton)
        
        playButton = utils.addImage(item: playButton, frameX: width*0.5, frameY: height*0.8, frameW: 0, frameH: 0, imageName: "start", interactionEnabled: true)
        self.view.addSubview(playButton)
        
        stopButton = utils.addImage(item: stopButton, frameX: width*0.5, frameY: height*0.8, frameW: 0, frameH: 0, imageName: "stop", interactionEnabled: true)
        self.view.addSubview(stopButton)
    }
    
    func addGestures(){
        
        previousButton.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(previousButtonPressed)))
        nextButton.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(nextButtonPressed)))
        playButton.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(startRound)))
        stopButton.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(stopRound)))
    }
    
    func previousButtonPressed(){
        if defaults.bool(forKey: "DefaultMusic"){
            previousDefault()
        }else{
            myMusicPlayer.skipToPreviousItem()
        }
        
    }
    
    func nextButtonPressed(){
        if defaults.bool(forKey: "DefaultMusic"){
            nextDefault()
        }else{
            myMusicPlayer.skipToNextItem()
        }
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
    
    func startRound(){
        stillPlaying = true
        let randomNum = arc4random_uniform(18) + 10
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(randomNum), target: self, selector: #selector(self.stopRound), userInfo: nil, repeats: false)
        self.playButton.isUserInteractionEnabled = false
        self.stopButton.isUserInteractionEnabled = true
        if defaults.bool(forKey: "DefaultMusic"){
            player?.play()
        }else{
            myMusicPlayer.play()
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, animations: {
            self.playButton.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            //self.playButton.transform = CGAffineTransform.identity.scaledBy(x: 0.0001, y: 0.0001)
            gradientLayer.colors = [UIColor(red: 20.0/255, green: 220.0/255, blue: 80.0/255, alpha: 1.0).cgColor, UIColor(red: 20.0/255, green: 240.0/255, blue: 90.0/255, alpha: 0.5).cgColor]
            
        }, completion: { (finish) in
            self.playButton.isHidden = true
            self.stopButton.isHidden = false
            
            self.utils.popItem(Duration: 0.7,Delay: 0.3, PopImage: self.stopButton, PositionX: width*0.5, PositionY: height*0.8, Width: width*0.25, Height: width*0.25 )
        })
    }
    
    func stopRound(){
        stillPlaying = false
        timer.invalidate()
        self.playButton.isUserInteractionEnabled = true
        self.stopButton.isUserInteractionEnabled = false
        if defaults.bool(forKey: "DefaultMusic"){
            player?.pause()
        }else{
            myMusicPlayer.pause()
        }
        UIView.animate(withDuration: 0.3, delay: 0, animations: {
            self.stopButton.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
            //self.stopButton.transform = CGAffineTransform.identity.scaledBy(x: 0.0001, y: 0.0001)
            gradientLayer.colors = [UIColor(red: 255.0/255, green: 55.0/255, blue: 85.0/255, alpha: 1.0).cgColor, UIColor(red: 255.0/255, green: 80.0/255, blue: 60.0/255, alpha: 0.5).cgColor]
        }, completion: { (finish) in
            
            self.playButton.isHidden = false
            self.stopButton.isHidden = true
            
            self.utils.popItem(Duration: 0.7,Delay: 0.3, PopImage: self.playButton, PositionX: width*0.5, PositionY: height*0.8, Width: width*0.25, Height: width*0.25 )
            
        })
        
        if (!defaults.bool(forKey: "ParcelWithList")){
            
            if (itemListPosition == itemListLength){
                itemListPosition = 0
                if (defaults.bool(forKey: "Random")){
                    randomiseList()
                }
            }
            
            let textToShow = itemList[itemListPosition]+"\n   "
            
            JSSAlertView().show(
                self,
                title: "Your Item:",
                text: textToShow,
                buttonText: "Fabulous",
                color: customColor,
                iconImage: customIcon)
            
            itemListPosition += 1
        }
    }
    
    func randomiseList(){
        //print(itemList)
        while itemList.count > 0{
            let randomIndex = Int(arc4random_uniform(UInt32(itemList.count)))
            randomList.append(itemList[randomIndex])
            itemList.remove(at: randomIndex)
        }
        itemList = randomList
        //print(itemList)
    }
    
    func swipeAllRight(){
        if defaults.bool(forKey: "DefaultMusic"){
            player?.pause()
        }else{
            myMusicPlayer.pause()
        }
        
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, animations: {
            /*
            self.backButton.transform = CGAffineTransform.identity.translatedBy(x: 1000, y: 0)
            self.titleText.transform = CGAffineTransform.identity.translatedBy(x: 1000, y: 0)
            self.section1.transform = CGAffineTransform.identity.translatedBy(x: 1000, y: 0)
            self.section2.transform = CGAffineTransform.identity.translatedBy(x: 1000, y: 0)
            self.libraryMusicText.transform = CGAffineTransform.identity.translatedBy(x: 1000, y: 0)
            self.DefaultMusicText.transform = CGAffineTransform.identity.translatedBy(x: 1000, y: 0)
            self.musicIcon.transform = CGAffineTransform.identity.translatedBy(x: 1000, y: 0)
            self.defaultMusicIcon.transform = CGAffineTransform.identity.translatedBy(x: 1000, y: 0)
            self.musicSelected.transform = CGAffineTransform.identity.translatedBy(x: 1000, y: 0)
            self.noMusicSelected.transform = CGAffineTransform.identity.translatedBy(x: 1000, y: 0)
            self.continueButton.transform = CGAffineTransform.identity.translatedBy(x: 1000, y: 0)
            self.musicSelected.transform = CGAffineTransform.identity.translatedBy(x: 1000, y: 0)
 */
        }, completion: { (finish) in
            self.goBackViewController()
        })
    }
    
    func goBackViewController(){
        gradientTimer.invalidate()
        NotificationCenter.default.removeObserver(self)
        let musicSelectionViewController:MusicSelectionViewController = MusicSelectionViewController()
        self.present(musicSelectionViewController, animated: false, completion: nil)
    }
    func goHomeViewController(){
        gradientTimer.invalidate()
    }
    
    func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(nowPlayingItemChanged), name: NSNotification.Name(rawValue: "MPMusicPlayerControllerNowPlayingItemDidChangeNotification"), object: nil)
    }
    
    func nowPlayingItemChanged(){
        if defaults.bool(forKey: "DefaultMusic"){
        }else{
            let nowPlaying = myMusicPlayer.nowPlayingItem
            let artworkImage = nowPlaying?.artwork?.image(at: CGSize(width: width*0.5, height: width*0.5))
            albumArtwork.image = artworkImage
            songTitle.text = nowPlaying?.title
            artist.text = nowPlaying?.artist
            album.text = nowPlaying?.albumTitle
        }
    }

}

extension UIImage {

    func scaleImageToSize(newSize: CGSize) -> UIImage {
        var scaledImageRect = CGRect.zero
        
        let aspectWidth = newSize.width/size.width
        let aspectheight = newSize.height/size.height
        
        let aspectRatio = max(aspectWidth, aspectheight)
        
        scaledImageRect.size.width = size.width * aspectRatio;
        scaledImageRect.size.height = size.height * aspectRatio;
        scaledImageRect.origin.x = (newSize.width - scaledImageRect.size.width) / 2.0;
        scaledImageRect.origin.y = (newSize.height - scaledImageRect.size.height) / 2.0;
        
        UIGraphicsBeginImageContext(newSize)
        draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
}
