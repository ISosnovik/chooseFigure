//
//  GameLogic.swift
//  Choose Figure
//
//  Created by Ivan Sosnovik on 11.02.16.
//  Copyright © 2016 ivansosnovik. All rights reserved.
//

import SpriteKit

let minNumberOfFigures = 3 // minimal number of figures to choose in level
let maxNumberOfFigures = 6 // maximal number of figures to choose in level
let bestScoreKey = "BestScore"

class GameLogic {
    // Delegate
    var delegate: GameEvents?
    
    // Protocol properties
    var deck: [String]  = []
    var rightFigureName: String?
    var lives: Int = 3 // number of lifes user has
    var bestScore: Int {
        get {
            return NSUserDefaults.standardUserDefaults().integerForKey(bestScoreKey) ?? 0
        }
        set {
            NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: bestScoreKey)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    var score: Int {
        get {
            return self.delegate?.level ?? 1 - 1
        }
        set {
            self.score = newValue
            if score > bestScore {
                self.bestScore = score
            }
        }
    }
    
    // Class properties
    // Figure settings
    var rightFigureIndex: Int?
    var deckOfIndices: [Int] = [] // array of indeces of figures
    var availableNames: [String] = [] // array of names of figures available in this level
    var numberOfFiguresToChoose: Int? // number of figures required to choose in this level
    var numberOfChosenFigures: Int = 0
    var deckSize: Int?

    // Initializer
    required init(delegate: GameEvents, deckSize: Int) {
        self.delegate = delegate
        self.deckSize = deckSize
        // number of figures to choose
        self.numberOfFiguresToChoose = Int.random(minNumberOfFigures...maxNumberOfFigures)
        
        let level = delegate.level
        self.availableNames = figureNamesForLevel(level)
        self.rightFigureIndex = Int.random(0...availableNames.count - 1)
        self.rightFigureName = availableNames[rightFigureIndex!]
        self.deckOfIndices = generateDeckOfIndices()
        self.deck = self.deckOfIndices.map({ index in
            availableNames[index]
        })
    }
}


// MARK: - Initial Setups
extension GameLogic {
    
    // configuration of levels
    private func figureNamesForLevel(level: Int) -> [String] {
        if level > 88 {
            return figureNamesForLevel(88)
        }
        
        if level == 1 {
            return ["1_1", "1_2", "1_3"]
        } else {
            var newImageName: [String] = []
            if level % 4 == 0 {
                newImageName += [String(level)]
            }
            return figureNamesForLevel(level - 1) + newImageName
        }
    }
    
    private func generateDeckOfIndices() -> [Int] {
        let forbiddenValue = rightFigureIndex!
        var deck = Int.randoms(deckSize!, minNum: 0, maxNum: availableNames.count - 1, forbiddenValues: [forbiddenValue])
        let chosenIndices = Int.uniqueRandoms(numberOfFiguresToChoose!, minNum: 0, maxNum: deckSize! - 1)
        for index in chosenIndices {
            deck[index] = rightFigureIndex!
        }
        return deck
    }
}


// MARK: Actions


extension GameLogic: GameActions {
    
    func userChoose(index: Int) {
        let indexOfFigure = deckOfIndices[index]
        
        if indexOfFigure == rightFigureIndex! {
            // Right figure
            self.delegate?.userDidRightChoice(index)
            self.numberOfChosenFigures += 1
            if numberOfChosenFigures == numberOfFiguresToChoose {
                self.delegate?.moveToNextLevel()
            }
        } else {
            // Wrong figure
            self.delegate?.userDidWrongChoice()
            self.lives -= 1
            if lives == 0 {
                self.delegate?.gameOver()
            }
        }
    }
    
}






