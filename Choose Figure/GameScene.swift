//
//  GameScene.swift
//  Choose Figure
//
//  Created by Ivan Sosnovik on 07.02.16.
//  Copyright (c) 2016 ivansosnovik. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene {
    var audioPlayer:AVAudioPlayer!
    var level: Int = 1
    var logic: GameActions?
        
    var levelLabelNode: SKLabelNode?
    var rightFigureNode: SKSpriteNode?
    var deckNodes: [SKSpriteNode] = []
    var lifeNodes: [SKSpriteNode] = []
    var lives: Int = 3
    
    
    // preparations
    override func didMove(to view: SKView) {

        // connect nodes with scene
        self.levelLabelNode = childNode(withName: "level") as? SKLabelNode
        self.rightFigureNode = childNode(withName: "rightFigure") as? SKSpriteNode
        enumerateChildNodes(withName: "//*") {
            node, stop in
            if node.name == "figure" {
                self.deckNodes.append(node as! SKSpriteNode)
            }
            if node.name == "life" {
                self.lifeNodes.append(node as! SKSpriteNode)
            }
        }
        // configure the label
        self.levelLabelNode?.text = String(level)
        // configure logic
        self.logic = GameLogic(delegate: self, deckSize: deckNodes.count)
        // Draw sprites
        drawDeck()
        drawRightFigure()
        drawLives()
    }
    
}


// MARK: - Drawings
extension GameScene {
    
    func drawDeck() {
        for (index, node) in deckNodes.enumerated() {
            let name = logic?.deck[index]
            node.texture = SKTexture(imageNamed: name!)
        }
    }
    
    func drawRightFigure() {
        let name = logic?.rightFigureName
        self.rightFigureNode?.texture = SKTexture(imageNamed: name!)
    }
    
    func drawLives() {
        if lives < 3 {
            for index in lives...2 {
                let node = lifeNodes[index]
                node.alpha = 0.2
            }
        }
    }
    
}

// MARK: - Event Delegation
extension GameScene: GameEvents {
    func gameSpeak(gametext: String) {
        let utterance = AVSpeechUtterance(string: gametext)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
        print(gametext)
    }
    
    func gameSound(sound: String) {
        let audioURL = URL(fileURLWithPath: Bundle.main.path(forResource: sound, ofType: "wav")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
            
            // check if audioPlayer is prepared to play audio
            if audioPlayer.prepareToPlay() {
                audioPlayer.play()
            }
        } catch {
            print(error)
        }
    }
    
    
    func userDidRightChoice(index: Int) {
        _ = deckNodes[index]
        gameSound(sound: "smb_coin")
    }
    
    func userDidWrongChoice() {
        if lives >= 1 {
            let index = lives - 1
            let lifeNode = lifeNodes[index]
            let action = SKAction.fadeAlpha(to: 0.2, duration: 0.1)
            lifeNode.run(action)
            gameSound(sound: "smb_bump")
            gameSpeak(gametext: "Oops, Wrong move!")
        } else {
            gameSpeak(gametext: "Sorry, out of lives!")
        }
    }
    
}

extension GameScene {
    
    func gameOver() {
        print("Game Over!!!")
    }
    
    func moveToNextLevel() {
        
        let transition = SKTransition.crossFade(withDuration: 0)
        
        let nextLevelScene = GameScene(fileNamed:"GameScene")
        if #available(iOS 10.0, *) {
            nextLevelScene!.backgroundColor = UIColor(
                displayP3Red: 1.0,
                green: 0.0,
                blue: 0.5,
                alpha: 1.0
            )
        } else {
            // Fallback on earlier versions
        }
        nextLevelScene!.level = level + 1
        gameSound(sound: "smb_stage_clear")
        let levelUpString = "Congrats! You moved to new level" +
            String(nextLevelScene!.level) + " and still have " +
            String(self.lives) + " lives left"
        gameSpeak(gametext: levelUpString)

        nextLevelScene!.lives = lives
        nextLevelScene!.scaleMode = SKSceneScaleMode.aspectFill
        self.scene!.view?.presentScene(nextLevelScene!, transition: transition)
    }
}

// MARK: - Touches
extension GameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let position = touch.location(in: self)
            let node = self.atPoint(position)
            if node.name == "figure" {
                let figure = node as? SKSpriteNode
                let index = deckNodes.index(of: figure!)
                self.logic?.userChoose(index: index!)
            }
        }
    }
}













