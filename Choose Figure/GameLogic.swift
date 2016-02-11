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

class GameLogic {
    
    var delegate: GameEvents?
    
    var chosenFigureIndex: Int?
    var chosenFigureName: String?
    
    var figureIndeces: [Int] = [] // array of indeces of figures
    var figureNames: [String] = [] // array of names of figures
    
    var numberOfFigures: Int? // number of figures required to choose
    var chosenNumberOfFigures: Int? // number of chose figures
    
    required init(delegate: GameEvents) {
        self.delegate = delegate
        
        // number of figures to choose
        self.numberOfFigures = Int(Float(drand48()) * Float((maxNumberOfFigures - minNumberOfFigures))) + minNumberOfFigures
        
        let level = delegate.level
        self.figureNames = figureNamesForLevel(level)
    }
    
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