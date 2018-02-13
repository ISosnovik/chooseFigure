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
    var bestScore: Int {
        get {
            return UserDefaults.standard.integer(forKey: bestScoreKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: bestScoreKey)
            UserDefaults.standard.synchronize()
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
    var deckOfIndices: [Int] = [] // array of indeces of figures
    var availableNames: [String] = [] // array of names of figures available in this level
    var numberOfFiguresToChoose: Int? // number of figures required to choose in this level
    var deckSize: Int?
    var rightFigureIndex: Int?
    var figuresToChoose: [Int] = []

    // Initializer
    required init(delegate: GameEvents, deckSize: Int) {
        self.delegate = delegate
        self.deckSize = deckSize
        // number of figures to choose
        self.numberOfFiguresToChoose = Int.random(minNum:minNumberOfFigures, maxNum:maxNumberOfFigures)
        
        let level = delegate.level
        self.availableNames = figureNamesForLevel(level: level)
        self.rightFigureIndex = Int.random(minNum:0, maxNum: availableNames.count - 1)
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
            return figureNamesForLevel(level: 88)
        }
        
        if level == 1 {
            return ["1_1", "1_2", "1_3"]
        } else {
            var newImageName: [String] = []
            if level % 4 == 0 {
                newImageName += [String(level)]
            }
            return figureNamesForLevel(level: level - 1) + newImageName
        }
    }
    
    private func generateDeckOfIndices() -> [Int] {
        let forbiddenValue = rightFigureIndex!
        var deck = Int.randoms(numberOfRandoms: deckSize!, minNum: 0, maxNum: availableNames.count - 1, forbiddenValues: [forbiddenValue])
        let chosenIndices = Int.uniqueRandoms(numberOfRandoms: numberOfFiguresToChoose!, minNum: 0, maxNum: deckSize! - 1)
        self.figuresToChoose = chosenIndices
        for index in chosenIndices {
            deck[index] = rightFigureIndex!
        }
        return deck
    }
}


// MARK: Actions


extension GameLogic: GameActions {
    
    func userChoose(index: Int) {
        let figureIndex = deckOfIndices[index]
        if figureIndex == rightFigureIndex {
            if let indexInArray = figuresToChoose.index(of: index){
                self.delegate?.userDidRightChoice(index: index)
                self.figuresToChoose.remove(at: indexInArray)
                if figuresToChoose.count == 0 {
                    self.delegate?.moveToNextLevel()
                }
            }
        } else {
            // Wrong figure
            self.delegate?.userDidWrongChoice()
            self.delegate?.lives -= 1
            if self.delegate?.lives == 0 {
                self.delegate?.gameOver()
            }
        }
    }
    
}






