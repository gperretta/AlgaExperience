//
//  SplashController.swift
//  AlgaExperience
//
//  Created by Alberto Di Ronza on 13/12/22.
//

import UIKit

class SplashController: UIViewController {
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.performSegue(withIdentifier: "PlayGame", sender: nil)
        }
    }
}

