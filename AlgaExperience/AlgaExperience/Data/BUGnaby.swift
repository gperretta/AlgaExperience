//
//  BUGnaby.swift
//  AlgaExperience
//
//  Created by Alberto Di Ronza on 12/12/22.
//

import Foundation
import SpriteKit

//useful to switch between animations
enum EnemyAnimationType: String {
    case walk
}

class BUGnaby : SKSpriteNode {
    // MARK: -Properties
    //Texture (Animation)
    private var walkTextures: [SKTexture]? //hold the walk texture
    
    // MARK: -Init
    //per l'inizializzazione delle texture
    init() {
        //set a default texture
        let texture = SKTexture(imageNamed: "enemy1")

        super.init(texture: texture, color: .clear, size: texture.size())
        
        //qua stai settando le animation texture(senza ancora animarle) chiamando la funzione loadtexture
        self.walkTextures = loadTexture(atlas: "BUGnaby", prefix: "enemy", startsAt: 1, stopsAt: 6)
        
//        self.name = "enemy"
        //self.zPosition = Layer.character
        //self.size = CGSize(width: size.width/5, height: size.height/4)
        
        // character body physics [approx. with a rectangle]
        self.physicsBody = SKPhysicsBody(
            rectangleOf: CGSize(width: 0.3*(self.size.width), height: 0.2*(self.size.height)),
            center: CGPoint(x: 0.3, y: 0.5))
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = Category.character
        self.physicsBody?.contactTestBitMask = Category.enemy
    }
    //usato per inizializzare sprite da scene file
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    //implemantazione azione camminata
    func walk(spriteSpeed: Double)
    {
        //check for textures
        guard let walkTextures = walkTextures else{
            preconditionFailure("Could not find Texture!")
        }
        //run te animation forever
        startAnimations(textures: walkTextures, speed: spriteSpeed, name: EnemyAnimationType.walk.rawValue, count: 0, resize: false, restore: false)
        //the higher speed the longer the frame displayed
  }
}

