//
//  StoredValue.swift
//  AlgaExperience
//
//  Created by Gilda on 10/12/22.
//

import Foundation

// just for convenience
enum Images {
    
    // placeholder(s)
    static let background = "sceneBackground"
    static let character = "pianta"
    static let enemy = "evilcat"
}

// Z axis (visual hierarchy)
enum Layer {
    
    static let background : CGFloat = 0
    static let character : CGFloat = 1
    static let enemy : CGFloat = 1
    static let effect : CGFloat = 2
    static let border : CGFloat = 3
}

// Physics categories for collision detection (bitmask)
enum Category {
    
    static let none : UInt32 = 0
    static let character : UInt32 = 1
    static let enemy : UInt32 = 2
}

enum TimeConstant {
    
    static let minSpeed : Double = 2    // enemies
    static let maxSpeed : Double = 3.5    // enemies
    static let waitTime : TimeInterval = 0.7  // enemies wave gen.
}

