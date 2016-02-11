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
    
    var level: Int = 1
    
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
    
    var currentScore: Int {
        
        get {
            return self.level - 1
        }

        set {
            self.currentScore = newValue
            if currentScore > bestScore {
                self.bestScore = currentScore
            }
        }
    }
    
    
    var levelLabelNode: SKLabelNode?
    var rightFigureNode: SKSpriteNode?
    var deckNodes: [SKSpriteNode] = []
    
    
    // preparations
    override func didMoveToView(view: SKView) {
        
        // connect nodes with scene
        self.levelLabelNode = childNodeWithName("level") as? SKLabelNode
        self.rightFigureNode = childNodeWithName("rightFigure") as? SKSpriteNode
        
        enumerateChildNodesWithName("//*") {
            node, stop in
            if node.name == "figure" {
                self.deckNodes.append(node as! SKSpriteNode)
            }
        }
        
        // configure the lebel label
        self.levelLabelNode?.text = String(level)
        
        let path = NSBundle.mainBundle().pathForResource("Images", ofType: "plist")
        
    }
    
}










