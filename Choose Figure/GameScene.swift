//
//  GameScene.swift
//  Choose Figure
//
//  Created by Ivan Sosnovik on 07.02.16.
//  Copyright (c) 2016 ivansosnovik. All rights reserved.
//

import SpriteKit



class GameScene: SKScene {
    
    var level: Int = 1
    var logic: GameActions?
        
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
        // configure the label
        self.levelLabelNode?.text = String(level)
        // configure logic
        self.logic = GameLogic(delegate: self, deckSize: deckNodes.count)
        
        print("Deck: \(logic?.deck)")
        
        // Draw sprites
        drawDeck()
        drawRightFigure()

        
    }
    
}


// MARK - Drawings
extension GameScene {
    
    func drawDeck() {
        for (index, node) in deckNodes.enumerate() {
            let name = logic?.deck[index]
            node.texture = SKTexture(imageNamed: name!)
        }
    }
    
    func drawRightFigure() {
        let name = logic?.rightFigureName
        self.rightFigureNode?.texture = SKTexture(imageNamed: name!)
    }
}

// MARK: - Event Delegation
extension GameScene: GameEvents {
    
    func userDidRightChoice(index: Int) {
        let node = deckNodes[index]
        // TODO: add action        
        // TODO: play sound
        // TODO: maybe splash
        print("Cool!!!!")
    }
    
    func userDidWrongChoice() {
        print("Fail!!! Lives: \(logic?.lives)")
    }
    
}

extension GameScene {
    
    func gameOver() {
        print("Game Over!!!")
    }
    
    func moveToNextLevel() {
        print("Next Level")
    }
}

// MARK: - Touches
extension GameScene {
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let position = touch.locationInNode(self)
            let node = self.nodeAtPoint(position)
            if node.name == "figure" {
                let figure = node as? SKSpriteNode
                let index = deckNodes.indexOf(figure!)
                self.logic?.userChoose(index!)
            }
        }
    }
}









