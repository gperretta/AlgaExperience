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
    case moves
}

class MainCharacterNode : SKSpriteNode {
    // MARK: -Properties
    //Texture (Animation)
    private var movesTextures: [SKTexture]? //hold the walk texture
    // MARK: -Init
    //per l'inizializzazione delle texture
    init(lives: Int) {
        //set a default texture
            let texture = SKTexture(imageNamed: "pianta32")
            
            super.init(texture: texture, color: .clear, size: texture.size())
            
            //qua stai settando le animation texture(senza ancora animarle) chiamando la funzione loadtexture
        if(lives == 3){
            self.movesTextures = loadTexture(atlas: "pianta", prefix: "pianta3", startsAt: 2, stopsAt: 13)}
        else if (lives == 2){
            self.movesTextures = loadTexture(atlas: "pianta1", prefix: "pianta2_", startsAt: 1, stopsAt: 12)}
        else if (lives == 1){
            self.movesTextures = loadTexture(atlas: "pianta2", prefix: "pianta2", startsAt: 1, stopsAt: 12)}
            
            self.name = "pianta"
            
            // character body physics [approx. with a rectangle]
            self.physicsBody = SKPhysicsBody(
                rectangleOf: CGSize(width: 0.3*(self.size.width), height: 0.2*(self.size.height)),
                center: CGPoint(x: 0.3, y: 0.5))
            self.physicsBody?.isDynamic = true
            self.physicsBody?.categoryBitMask = Category.character
            self.physicsBody?.contactTestBitMask = Category.enemy
            self.physicsBody?.collisionBitMask = Category.none}
    
    //usato per inizializzare sprite da scene file
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: -GoesOut
    //implemantazione azione camminata
    func moves()
{
        //check for textures
        guard let movesTextures = movesTextures else{
            preconditionFailure("Could not find Texture!")
        }
        startAnimations(textures: movesTextures, speed: 0.25, name: PlayerAnimationType.moves.rawValue, count: 1, resize: false, restore: false)
        //the higher speed the longer the frame displayed
 }
}
