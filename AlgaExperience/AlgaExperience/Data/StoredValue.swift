//
//  StoredValue.swift
//  AlgaExperience
//
//  Created by Gilda on 10/12/22.
//

import Foundation

// just for convenience
enum Images {
    
    static let background = "sceneBackground"
    static let background2 = "gameOver"
    static let background3 = "loreBackground"
    static let pause = "pauseButton"
    static let resume = "playButton"
    static let retry = "retryButton"
    static let bordo = "bordo"
}

// Z axis (visual hierarchy)
enum Layer {
    
    static let background : CGFloat = 0
    static let character : CGFloat = 1
    static let enemy : CGFloat = 1
    static let effect : CGFloat = 3
    static let border : CGFloat = 3
    static let buttons : CGFloat = 4
}

// Physics categories for collision detection (bitmask)
enum Category {
    
    static let none : UInt32 = 0
    static let character : UInt32 = 1
    static let enemy : UInt32 = 2
}

enum TimeConstant {
    
    static let minDuration : Double = 3   // enemies
    static let maxDuration : Double = 6   // enemies
    static let waitTime : TimeInterval = 1  // enemies wave gen.
}


