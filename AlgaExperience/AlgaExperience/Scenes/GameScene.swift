//
//  GameScene.swift
//  AlgaExperience
//
//  Created by Gilda on 06/12/22.
//

import SpriteKit

//MARK: -Operator overloading

func +(left: CGPoint, right: CGPoint) -> CGPoint {
return CGPoint(x: left.x + right.x, y: left.y + right.y)
}
func -(left: CGPoint, right: CGPoint) -> CGPoint {
return CGPoint(x: left.x - right.x, y: left.y - right.y)
}
func *(point: CGPoint, scalar: CGFloat) -> CGPoint {
return CGPoint(x: point.x * scalar, y: point.y * scalar)
}
func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
func sqrt(a: CGFloat) -> CGFloat {
  return CGFloat(sqrtf(Float(a)))
}
#endif

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    func normalized() -> CGPoint {  // mod: 1
        return self / length()
    }
}

func random() -> CGFloat {
  return CGFloat(Float(arc4random()) / Float(0xFFFFFFFF))
}
func random(min: CGFloat, max: CGFloat) -> CGFloat {
  return random() * (max - min) + min
}

//MARK: -Init GameScene class

var traceBg : SKShapeNode!
var traceFg : SKShapeNode!
var tracePoints : [CGPoint] = []

var firstLaunch : Bool = true

class GameScene: SKScene {

    var enemiesDestroyed = 0 {
        didSet { scoreBar.text = "SCORE: \(enemiesDestroyed)" }
    }
    var scoreBar = SKLabelNode()
    var livesLeft = 3 {
        didSet { livesLeftBar.text = "LIVES: \(livesLeft)/3" }
    }
    var livesLeftBar = SKLabelNode(fontNamed: "Modern DOS 9x16")
    var touchLocation : CGPoint = CGPoint(x: 0, y: 0)
    
    override func didMove(to view: SKView) {
        //lancia la lore screen sfruttando il controllo sul booleano first Launch
        if firstLaunch {
            let reveal = SKTransition.flipHorizontal(withDuration: 0.25)
            let sceneLore = LoreScene(size: self.size)
            self.view?.presentScene(sceneLore, transition: reveal)
            firstLaunch = false
        }
        // scene and main character node rendering:
        setBackground()
        addMainCharacter(zPos: Layer.character)
        // (not) to deal with some physics:
        setScenePhysics()
        // enemies wave:
        setLoop()
        // user interactions:
        setSwipeTrace()
        displayUIBar()
    }
    
    // core mechanic:
    func enemyCollideAttack(enemy: SKSpriteNode, character: SKSpriteNode) {
        print("COLLIDE ATTACK SUCCEDED")
        enemy.removeFromParent()
        livesLeft -= 1
        print("Leaves: \(livesLeft)")  // just for the test sake
        //
        //if livesLeft == 2 {reverse animation}
        //if livesLeft == 1 {reverse animation}
        //
        if livesLeft == 0 {
            character.removeFromParent()
            run(SKAction.sequence([
                SKAction.wait(forDuration: 0.25),
                SKAction.run() {
                    let reveal = SKTransition.flipHorizontal(withDuration: 0.25)
                let scene = GameOverScene(size: self.size, won: false)
                    self.view?.presentScene(scene, transition: reveal)
              }
            ]))
        } else if livesLeft > 0 {
            character.removeFromParent()
            addMainCharacter(zPos: Layer.border)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                print("Waiting time ended after 2 s")
                
            }
        }
    }
}

//MARK: -Setup (extension)

extension GameScene {
    
    func setBackground() {
        
        let background = SKSpriteNode(imageNamed: Images.background)
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        background.zPosition = Layer.background
        background.size = CGSize(width: size.width, height: size.height)
        addChild(background)
        
        let bordo = SKSpriteNode(imageNamed: Images.bordo)
        bordo.anchorPoint = CGPoint(x: 0, y: 0)
        bordo.position = CGPoint(x: 0, y: 0)
        bordo.zPosition = Layer.border
        bordo.size = CGSize(width: size.width, height: size.height)
        addChild(bordo)
    }
    // main character:
    func addMainCharacter(zPos : CGFloat) {
        let pianta = MainCharacterNode()
        pianta.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pianta.position = CGPoint(x: size.width/2, y: size.height/2)
        pianta.size = CGSize(width: 0.5*(pianta.size.width), height: 0.5*(pianta.size.height))
        pianta.zPosition = zPos
        addChild(pianta)
        pianta.goesOut()
    }
    // opponents:
    func addEnemies() {
        let enemy = BUGnaby()
        enemy.name = "enemies"
        enemy.size = CGSize(width: 0.07*(size.width), height: 0.15*(size.height))
        // DA RIVEDERE questa parte perché da qui inizia tanto codice inutile sec me
        // questa è l'unica alternativa che sono stata capace di trovare rn LOL
        let xRight = size.width + enemy.size.width/2
        let xLeft = -(xRight)
        let xRange = random(min: enemy.size.width/2, max: size.width - enemy.size.width/2)
        let yRange = random(min: enemy.size.height/2, max: size.height - enemy.size.height/2)
        let yTop = size.height + enemy.size.height/2
        let yBottom = -(yTop)
        let flag : Int = Int.random(in: 1...4)
        switch flag {
        case (1) :
            enemy.position = CGPoint(x: xRange, y: yTop)
        case (2) :
            enemy.position = CGPoint(x: xRange, y: yBottom)
        case (3) :
            enemy.position = CGPoint(x: xRight, y: yRange)
        case (4) :
            enemy.position = CGPoint(x: xLeft, y: yRange)
        default:
            enemy.position = CGPoint(x: xRange, y: yTop)
        }
        // add the child after checking its position:
        addChild(enemy)
        enemy.walk()
        // enemies body physics [approx. with a rectangle]
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody?.isDynamic = true
        enemy.physicsBody?.categoryBitMask = Category.enemy
        enemy.physicsBody?.contactTestBitMask = Category.character
        // enemies can go through each other (I guess?)
        enemy.physicsBody?.collisionBitMask = Category.none
        enemy.physicsBody?.usesPreciseCollisionDetection = true // bc they're fast!
        
        setMovemement(node: enemy)
    }
    // enemies movement from their starting position to the mc:
    func setMovemement(node: SKSpriteNode) {
        
        let movementDuration = Double.random(in: (TimeConstant.minDuration)...(TimeConstant.maxDuration))

        let actionMove = SKAction.move(to: CGPoint(x: size.width/2, y: size.height/2),
                                     duration: movementDuration)
        let actionMoveDone = SKAction.removeFromParent()

        node.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    // endless loop for the waves of enemies generation:
    func setLoop() {
        print("Sprout generation waiting time...")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            print("Waiting time ended after 2 s")
            
            self.run(SKAction.repeatForever(SKAction.sequence([
                SKAction.run(self.addEnemies),
                SKAction.wait(forDuration: TimeConstant.waitTime)
            ])
            ))
        }
//     }
    }
    // note: world physics is different from body physics!
    func setScenePhysics() {
      // the scene isn't subjected to gravity acceleration:
      physicsWorld.gravity = .zero
      // to notify the scene when two physics bodies collide:
      physicsWorld.contactDelegate = self
    }
}

//MARK: -Touch handling (extension)

extension GameScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesBegan(touches, with: event)
        
      tracePoints.removeAll(keepingCapacity: true)
      for _ in touches {
          guard let touch = touches.first
          else { return }
          let location = touch.location(in: self)
          let nodeClicked = atPoint(touch.location(in: self))
          // if the user taps on pause button:
          if nodeClicked.name == "pausebtn" {
              
              if isPaused { return }
              isPaused = true
              print("Game paused")
              // forse dovrei lavorare con hide/unhide action
              // invece di rimuovere/ricreare il nodo ma,,,
              nodeClicked.removeFromParent()
              addResumeButton()
          }
          // & resume button:
          else if nodeClicked.name == "resumebtn" {
              
              if !isPaused { return }
              isPaused = false
              print("Game resumed")
              nodeClicked.removeFromParent()
              addPauseButton()
          }
          // if the user is just swiping on screen:
          else {
              
              tracePoints.append(location)
              redrawSwipeTrace()
              
              traceFg.removeAllActions()
              traceBg.removeAllActions()
              traceFg.alpha = 1.0
              traceBg.alpha = 1.0
          }
      }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesEnded(touches, with: event)
        // the effect fades out when the touch ends
        let fadeOutBg = SKAction.fadeOut(withDuration: 0.2)
        let fadeOutFg = SKAction.fadeOut(withDuration: 0.2)
        traceBg.run(fadeOutBg)
        traceFg.run(fadeOutFg)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesMoved(touches, with: event)

        guard let touch = touches.first
        else { return }
        let location = touch.location(in: self)

        tracePoints.append(location)
        redrawSwipeTrace()

        // if the user swipes on the selected  node (enemies):
        let nodeSelected = nodes(at: location)
        for node in nodeSelected {
          if node.name == "enemies" {
            node.name = nil
            node.physicsBody?.isDynamic = false

            let fadeOut = SKAction.fadeOut(withDuration: 0.2)
            let sequence = SKAction.sequence([fadeOut, .removeFromParent()])
            node.run(sequence)
            enemiesDestroyed+=1
            print("Score: \(enemiesDestroyed)")

            if enemiesDestroyed > 100 {   // just for the test sake
                  run(SKAction.run() {
                      let reveal = SKTransition.push(with: .up, duration: 0.25)
                      let scene = GameOverScene(size: self.size, won: true)
                      self.view?.presentScene(scene, transition: reveal)
                    })
              }
        }
      }
    }
}

//MARK: -Swipe visual effect (extension)

extension GameScene {

    func setSwipeTrace() {
        
        traceBg = SKShapeNode()
        traceBg.zPosition = Layer.border
        traceBg.lineWidth = 4.0
        traceBg.strokeColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
      
        traceFg = SKShapeNode()
        traceFg.zPosition = Layer.border
        traceFg.lineWidth = 2.0
        traceFg.strokeColor = .white
      
       addChild(traceBg)
       addChild(traceFg)
    }

    func redrawSwipeTrace() {
      
        // min swipe lenght:
        if tracePoints.count < 3 {
            traceBg.path = nil
            traceFg.path = nil
            return
        }
        // max swipe lenght:
        while tracePoints.count > 12 {
            tracePoints.remove(at: 0)
        }
      
        let bezierPath = UIBezierPath()
        bezierPath.move(to: tracePoints[0])
        // draw swipe trace:
        for i in 0..<tracePoints.count {
            bezierPath.addLine(to: tracePoints[i])
        }
      
        traceBg.path = bezierPath.cgPath
        traceFg.path = bezierPath.cgPath
    }
}

//MARK: -Contact handling (protocol)

extension GameScene: SKPhysicsContactDelegate {

    func didBegin(_ contact: SKPhysicsContact) {

      // note: the contact delegate doesn't guarantee any particular order
      var firstBody: SKPhysicsBody
      var secondBody: SKPhysicsBody
      if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
        firstBody = contact.bodyA
        secondBody = contact.bodyB
      } else {
        firstBody = contact.bodyB
        secondBody = contact.bodyA
     }  // -> now it will use the order based on the assigned categories.

      // and now a check:
      if ((firstBody.categoryBitMask & Category.character != 0) &&
          (secondBody.categoryBitMask & Category.enemy != 0)) {
      if let enemy = firstBody.node as? SKSpriteNode,
        let character = secondBody.node as? SKSpriteNode {
          enemyCollideAttack(enemy: enemy, character: character)
      }
    }
  }
}

//MARK: -UI controller on screen (extension)

extension GameScene {
    
    func displayUIBar() {
        
        addPauseButton()
        //showLivesLeft()
        //showScore()
    }
    
    func addPauseButton() {
        
        let pauseButton = SKSpriteNode(imageNamed: Images.pause)
        pauseButton.name = "pausebtn"
        pauseButton.position = CGPoint(x: size.width - 0.1*(size.width), y: 0.9*(size.height))
        pauseButton.zPosition = Layer.buttons
        addChild(pauseButton)
    }
    
    func addResumeButton() {
        
        let resumeButton = SKSpriteNode(imageNamed: Images.resume)
        resumeButton.name = "resumebtn"
        resumeButton.position = CGPoint(x: size.width - 0.1*(size.width), y: 0.9*(size.height))
        resumeButton.zPosition = Layer.buttons
        addChild(resumeButton)
    }
    
    func showLivesLeft() {
        
        livesLeftBar.name = "livesBar"
        livesLeftBar.text = "Lives: \(livesLeft)/3"
        livesLeftBar.fontSize = 32
        livesLeftBar.color = SKColor.white
        livesLeftBar.position = CGPoint(x: 0.15*(size.width), y: 0.85*(size.height))
        addChild(livesLeftBar)
    }
    
    func showScore() {
        
        scoreBar.name = "livesBar"
        scoreBar.text = "SCORE: \(enemiesDestroyed)"
        scoreBar.fontSize = 28
        scoreBar.color = SKColor.white
        scoreBar.position = CGPoint(x: size.width - 0.1*(size.width), y: 0.9*(size.height))
        addChild(scoreBar)
    }
}


