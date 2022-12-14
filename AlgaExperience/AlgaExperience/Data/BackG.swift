//
//  BackG.swift
//  AlgaExperience
//
//  Created by Alberto Di Ronza on 14/12/22.
//

import Foundation
import SpriteKit

//useful to switch between animations
enum BackgAnimationType: String {
    case animate
}

class BackG : SKSpriteNode {
    // MARK: -Properties
    private var animateTextures: [SKTexture]?
    
    // MARK: -Init
    init() {
        let texture = SKTexture(imageNamed: "frame_0")

        super.init(texture: texture, color: .clear, size: texture.size())

        self.animateTextures = loadTexture(atlas: "LoreBackground", prefix: "frame_", startsAt: 0, stopsAt: 75)
    }
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animate()
    {
        guard let animateTextures = animateTextures else{
            preconditionFailure("Could not find Texture!")
        }
        startAnimations(textures: animateTextures, speed: 0.10, name: BackgAnimationType.animate.rawValue, count: 1, resize: false, restore: false)
  }
}

