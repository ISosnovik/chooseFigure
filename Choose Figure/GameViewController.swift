//
//  GameViewController.swift
//  Choose Figure
//
//  Created by Ivan Sosnovik on 07.02.16.
//  Copyright (c) 2016 ivansosnovik. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            if #available(iOS 10.0, *) {
                scene.backgroundColor = UIColor(
                    displayP3Red: 1.0,
                    green: 0.0,
                    blue: 0.5,
                    alpha: 1.0
                )
            } else {
                // Fallback on earlier versions
            }
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            
            skView.presentScene(scene)
        }
    }
    
    override open var shouldAutorotate: Bool {
        return true
    }

//    override func shouldAutorotate() -> Bool {
//        return true
//    }
//
//    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            return .allButUpsideDown
//        } else {
//            return .all
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
}
