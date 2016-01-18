//
//  Sound.swift
//  Opema
//
//  Created by Gazolla on 15/09/15.
//  Copyright (c) 2015 Gazolla. All rights reserved.
//

import Foundation
import AVFoundation

class Sound: NSObject {
    
    class var sharedInstance: Sound {
        struct Singleton {
            static let instance = Sound()
        }
        return Singleton.instance
    }
    
    func playFromBundleString(name:String) {
        if let path = NSBundle.mainBundle().pathForResource(name, ofType:"mp3") {
            let url = NSURL.fileURLWithPath(path)
            var soundID:SystemSoundID = 0
            AudioServicesCreateSystemSoundID(url, &soundID);
            AudioServicesPlaySystemSound(soundID);
        }
        
    }
    
    func playWaveFromBundleString(name:String) {
        if let path = NSBundle.mainBundle().pathForResource(name, ofType:"wav") {
            let url = NSURL.fileURLWithPath(path)
            var soundID:SystemSoundID = 0
            AudioServicesCreateSystemSoundID(url, &soundID);
            AudioServicesPlaySystemSound(soundID);
        }
        
    }
    
    func playM4aFromBundleString(name:String) {
        if let path = NSBundle.mainBundle().pathForResource(name, ofType:"m4a") {
            let url = NSURL.fileURLWithPath(path)
            var soundID:SystemSoundID = 0
            AudioServicesCreateSystemSoundID(url, &soundID);
            AudioServicesPlaySystemSound(soundID);
        }
        
    }


}
