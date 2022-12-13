//
//  GameOverScene.swift
//  AlgaExperience
//
//  Created by Gilda on 10/12/22.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
  
 //MARK: -Init
    
   // il parametro 'won' serviva per differenziare vittoria/sconfitta
  init(size: CGSize, won:Bool) {
    super.init(size: size)
    backgroundColor = SKColor.black
      
      let gameOverText = SKLabelNode(fontNamed: "Modern DOS 9x16")
      gameOverText.text = "GAME OVER"
      gameOverText.fontSize = 72
      gameOverText.fontColor = SKColor.white
      gameOverText.position = CGPoint(x: size.width/2, y:  0.75*(size.height))
      addChild(gameOverText)
      
      let retryButton = SKSpriteNode(imageNamed: Images.retry)
      retryButton.name = "retrybtn"
      retryButton.position = CGPoint(x: size.width/2, y:  0.25*(size.height))
      addChild(retryButton)
   }
  // override an initializer:
  required init(coder aDecoder: NSCoder) {
    fatalError("dummy text bc it won't be called")
  }
    
 //MARK: -Touch handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesBegan(touches, with: event)

        guard let touch = touches.first
        else { return }
        let nodeClicked = atPoint(touch.location(in: self))
        // if the user taps on retry button:
        if nodeClicked.name == "retrybtn" {
            
            run(SKAction.run() { [weak self] in
                // transition to a new scene in SpriteKit
                guard let `self` = self
                else { return }
                // add some transition:
                let reveal = SKTransition.push(with: .up, duration: 0.25)
                let scene = GameScene(size: self.size)
                self.view?.presentScene(scene, transition:reveal)
              }
              )
          }
      }
}
