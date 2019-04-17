//
//  Sounds.swift
//  EnhanceQuizStarter
//
//  Created by Dipanshu Sehrawat on 17/04/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation
import AudioToolbox

struct Sound {
    static var gameSound: SystemSoundID = 0
    static var correctAnswerSound: SystemSoundID = 1335
    static var inCorrectAnswerSound: SystemSoundID = 1329
    static var timeUpSound: SystemSoundID = 1005
    
    static func loadGameStartSound() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    static func playCorrectAnswerSound() {
        AudioServicesPlaySystemSound(correctAnswerSound)
    }
    
    static func playIncorrectAnswerSound() {
        AudioServicesPlaySystemSound(inCorrectAnswerSound)
    }
    
    static func playTimeUpSound() {
        AudioServicesPlaySystemSound(timeUpSound)
    }
    
    static func playGameSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}

























