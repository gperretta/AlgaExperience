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
    backgroundColor = SKColor.white
    // based on the parameter:
    let message = won ? "YOU WON 🥳" : "YOU LOST ☹️"    //placeholder
    // label node = text on the screen with SpriteKit
    let resultText = SKLabelNode()
    resultText.text = message
    resultText.fontSize = 40
    resultText.fontColor = SKColor.black
    resultText.position = CGPoint(x: size.width/2, y: size.height/2)
    addChild(resultText)
    
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

