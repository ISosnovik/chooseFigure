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
    
    func userDidRightChoice()
    func userDidWrongChoice()
    
    func gameOver()
    func moveToNextLevel()
    
}
