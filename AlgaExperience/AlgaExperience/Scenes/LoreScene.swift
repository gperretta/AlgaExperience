//
//  LoreScene.swift
//  AlgaExperience
//
//  Created by Alberto Di Ronza on 13/12/22.
//

import UIKit
import SpriteKit

class LoreScene: SKScene {
  
    override init(size: CGSize) {
    super.init(size: size)
        
    backgroundColor = SKColor.black
      
      let background3 = BackG()
        background3.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background3.position = CGPoint(x: size.width/2, y: size.height/2)
        background3.zPosition = Layer.background
        background3.size = CGSize(width: size.width, height: (size.height)*1.2)
        let typeNode = SKAudioNode(fileNamed: "textMusic1")
        addChild(background3)
        addChild(typeNode)
        background3.animate()

    
    run(SKAction.sequence([
      SKAction.wait(forDuration: 7.5), //was 21.5
      SKAction.run() { [weak self] in
        // transition to a new scene in SpriteKit
        guard let `self` = self
        else { return }
        // add some transition:
        let reveal = SKTransition.push(with: .up, duration: 0.25)
        let scene = GameScene(size: size)
        self.view?.presentScene(scene, transition: reveal)
      }
      ]))
   }
  
  // override an initializer:
  required init(coder aDecoder: NSCoder) {
    fatalError("dummy text bc it won't be called")
  }
    
}

