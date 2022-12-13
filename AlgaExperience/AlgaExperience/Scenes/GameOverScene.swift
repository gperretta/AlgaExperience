//
//  GameOverScene.swift
//  AlgaExperience
//
//  Created by Gilda on 10/12/22.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
  
  init(size: CGSize, won:Bool) {
    super.init(size: size)
    // DA DECIDERE
    backgroundColor = SKColor.black
      
      let background2 = SKSpriteNode(imageNamed: Images.background2)
      background2.anchorPoint = CGPoint(x: 0, y: 0)
      background2.position = CGPoint(x: 0, y: 0)
      background2.zPosition = Layer.background
      background2.size = CGSize(width: size.width, height: size.height)
      addChild(background2)

    
    run(SKAction.sequence([
      // wait for 3 sec and run
      SKAction.wait(forDuration: 3.0),
      SKAction.run() { [weak self] in
        // transition to a new scene in SpriteKit
        guard let `self` = self
        else { return }
        // add some transition:
        let reveal = SKTransition.push(with: .up, duration: 0.25)
        let scene = GameScene(size: size)
        self.view?.presentScene(scene, transition:reveal)
      }
      ]))
   }
  
  // override an initializer:
  required init(coder aDecoder: NSCoder) {
    fatalError("dummy text bc it won't be called")
  }
}

