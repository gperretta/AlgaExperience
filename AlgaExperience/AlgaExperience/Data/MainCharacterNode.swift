//
//  MainCharacter.swift
//  AlgaExperience
//
//  Created by Alberto Di Ronza on 12/12/22.
//
import Foundation
import SpriteKit

//useful to switch between animations
enum PlayerAnimationType: String {
    case goesOut
}

class MainCharacterNode : SKSpriteNode {
    // MARK: -Properties
    //Texture (Animation)
    private var goesOutTextures: [SKTexture]? //hold the walk texture
    
    // MARK: -Init
    //per l'inizializzazione delle texture
    init() {
        //set a default texture
        let texture = SKTexture(imageNamed: "pianta2")

        super.init(texture: texture, color: .clear, size: texture.size())
        
        //qua stai settando le animation texture(senza ancora animarle) chiamando la funzione loadtexture
        self.goesOutTextures = loadTexture(atlas: "pianta", prefix: "pianta", startsAt: 2, stopsAt: 13)
        
        self.name = "pianta"
        //self.zPosition = Layer.character
        //self.size = CGSize(width: size.width/5, height: size.height/4)
        
        // character body physics [approx. with a rectangle]
        self.physicsBody = SKPhysicsBody(
            rectangleOf: CGSize(width: self.size.width/3.5, height: self.size.height/2.5),
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
    func goesOut()
    {
        //check for textures
        guard let goesOutTextures = goesOutTextures else{
            preconditionFailure("Could not find Texture!")
        }
        //run te animation forever
        startAnimations(textures: goesOutTextures, speed: 0.25, name: PlayerAnimationType.goesOut.rawValue, count: 1, resize: false, restore: false)
        //the higher speed the longer the frame displayed
  }
}
