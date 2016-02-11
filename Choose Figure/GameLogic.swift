//
//  GameLogic.swift
//  Choose Figure
//
//  Created by Ivan Sosnovik on 11.02.16.
//  Copyright © 2016 ivansosnovik. All rights reserved.
//

import SpriteKit

let minNumberOfFigures = 4 // minimal number of figures to choose in level
let maxNumberOfFigures = 6 // maximal number of figures to choose in level
let bestScoreKey = "BestScore"

class GameLogic {
    // Delegate
    var delegate: GameEvents?
    
    // Figure settings
    var chosenFigureIndex: Int?
    var figureIndeces: [Int] = [] // array of indeces of figures
    var availableNames: [String] = [] // array of names of figures available in this level
    var numberOfFigures: Int? // number of figures required to choose
    var chosenNumberOfFigures: Int? // number of chose figures
    
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
    required init(delegate: GameEvents) {
        self.delegate = delegate
        
        // number of figures to choose
        self.numberOfFigures = Int.random(minNumberOfFigures...maxNumberOfFigures)
        
        let level = delegate.level
        self.availableNames = figureNamesForLevel(level)
        self.chosenFigureIndex = Int(arc4random_uniform(UInt32(availableNames.count)))
        
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
}


// MARK: Actions

extension GameLogic: GameActions {
    
    func userDidChoice(index: Int) {
        
    }
}






