//
//  GameScene.swift
//  Choose Figure
//
//  Created by Ivan Sosnovik on 07.02.16.
//  Copyright (c) 2016 ivansosnovik. All rights reserved.
//

import SpriteKit

let bestScoreKey = "BestScore"

class GameScene: SKScene {
    
    // Score settings
    private var bestScore: Int? {
        get {
            return NSUserDefaults.standardUserDefaults().integerForKey(bestScoreKey) ?? 0
        }
        
        set {
            NSUserDefaults.standardUserDefaults().setInteger(newValue!, forKey: bestScoreKey)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var currentScore: Int? {
        
        get {
            return self.currentScore ?? 0
        }

        set {
            self.currentScore = newValue
            if currentScore > bestScore {
                self.bestScore = currentScore
            }
        }
    }
    
    // Main lifecycle setups
    override func didMoveToView(view: SKView) {
        
        
    }
    
}


extension GameScene {
    
    func newLevel() {
        
    }
        
}







