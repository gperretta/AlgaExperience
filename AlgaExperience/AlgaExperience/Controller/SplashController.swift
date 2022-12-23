//
//  SplashController.swift
//  AlgaExperience
//
//  Created by Alberto Di Ronza on 13/12/22.
//

import UIKit
import AVFoundation

class SplashController: UIViewController {
    var audioPlayer = AVAudioPlayer()
    
    func playSound(file:String, ext:String) -> Void {
            do {
                let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: file, ofType: ext)!)
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch let error {
                NSLog(error.localizedDescription)
            }
        }
    
    override func viewDidLoad()
    {
        playSound(file: "VENTO", ext: "wav")
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.performSegue(withIdentifier: "PlayGame", sender: nil)
        }
    }
}

