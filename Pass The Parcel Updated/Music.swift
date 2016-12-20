//
//  Music.swift
//  Pass The Parcel Updated
//
//  Created by Chris Harrison on 15/12/2016.
//  Copyright © 2016 Chris Harrison. All rights reserved.
//

import Foundation
import AVFoundation

var BackgroundMusicPlayer: AVAudioPlayer = AVAudioPlayer()
var shakeSoundPlayer:AVAudioPlayer!

class Music {
    let songs = ["Pas_de_Deux.mp3","If_I_Had_a_Chicken.mp3","Earthy_Crust.mp3","Done_Runnin.mp3","Always_Hopeful.mp3","Millicent.mp3","Hit_the_Switch.mp3","Dutty.mp3","Invisible.mp3","Blue_Skies.mp3","Bomba_Pa_Siempre.mp3","The_Only_Girl.mp3","Do_It_Right.mp3","Crawdad_Stomp.mp3","Avocado_Street.mp3","Hooky_with_Sloane.mp3","Morning_Stroll.mp3","Walking_the_Dog.mp3","Happy_Mandolin.mp3","Epiclogue.mp3","Darktown_Strutters_Ball.mp3","Brontosaurus.mp3","Cheating_Juarez.mp3","Higher.mp3"]
    
    
    func startBackgroundMusic(){
        if let BackgroundMusic = Bundle.main.url(forResource: "music", withExtension: "mp3") {
            do {
                BackgroundMusicPlayer = try AVAudioPlayer(contentsOf: BackgroundMusic)
                BackgroundMusicPlayer.prepareToPlay()
                BackgroundMusicPlayer.volume = 0.4
                BackgroundMusicPlayer.numberOfLoops = -1
                BackgroundMusicPlayer.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func prepShakeSound(){
        if let shakeSound = Bundle.main.url(forResource: "shake", withExtension: "wav") {
            do {
                shakeSoundPlayer = try AVAudioPlayer(contentsOf: shakeSound)
                shakeSoundPlayer.prepareToPlay()
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    

}
