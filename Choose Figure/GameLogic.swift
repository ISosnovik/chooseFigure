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
    
    // Figure settings
    var chosenFigureIndex: Int?
    var deck: [Int] = [] // array of indeces of figures
    var availableNames: [String] = [] // array of names of figures available in this level
    var numberOfFiguresToChoose: Int? // number of figures required to choose
    var numberOfChosenFigures: Int = 0 // number of chose figures
    var deckSize: Int? // number of figures in the deck
    
    // Score settings
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
    
    // Initializer
    required init(delegate: GameEvents, deckSize: Int) {
        self.delegate = delegate
        self.deckSize = deckSize
        // number of figures to choose
        self.numberOfFiguresToChoose = Int.random(minNumberOfFigures...maxNumberOfFigures)
        
        let level = delegate.level
        self.availableNames = figureNamesForLevel(level)
        self.chosenFigureIndex = Int.random(0...availableNames.count - 1)
        self.deck = generateDeck()
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
    
    
    private func generateDeck() -> [Int] {
        let forbiddenValue = chosenFigureIndex!
        var deck = Int.randoms(deckSize!, minNum: 0, maxNum: availableNames.count - 1, forbiddenValues: [forbiddenValue])
        let chosenIndices = Int.uniqueRandoms(numberOfFiguresToChoose!, minNum: 0, maxNum: deckSize! - 1)
        for index in chosenIndices {
            deck[index] = chosenFigureIndex!
        }
        return deck
    }
}


// MARK: Actions


extension GameLogic: GameActions {
    
    func userDidChoice(index: Int) {
        
    }
}






