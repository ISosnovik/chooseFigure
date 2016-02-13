//
//  GameEvents.swift
//  Choose Figure
//
//  Created by Ivan Sosnovik on 11.02.16.
//  Copyright © 2016 ivansosnovik. All rights reserved.
//

import Foundation

protocol GameEvents {
    
    var level: Int { get set }
    var lives: Int { get set }
    
    func userDidRightChoice(index: Int)
    func userDidWrongChoice()
    
    func gameOver()
    func moveToNextLevel()
    
}
