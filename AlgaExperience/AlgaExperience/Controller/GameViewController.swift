//
//  GameViewController.swift
//  AlgaExperience
//
//  Created by Gilda on 06/12/22.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // root view:
        if let view = self.view as! SKView? {
            let scene = GameScene(size: view.bounds.size)
            // display frame rate indicator and node counter:
            view.showsFPS = true
            view.showsNodeCount = true
            // note: sibling objects are rendered in array order
            // -> useful when we'll need overlapping objects!
            view.ignoresSiblingOrder = false
            // the scene is automatically resized to match the view dimension
            scene.scaleMode = .resizeFill
            // forse da rivedere: qual è il migliore scaleMode?
            // e.g.: .aspectFill potrebbe tagliare la scena etc
            
            view.presentScene(scene)
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
