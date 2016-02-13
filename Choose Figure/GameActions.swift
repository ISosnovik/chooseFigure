//
//  GameActions.swift
//  Choose Figure
//
//  Created by Ivan Sosnovik on 11.02.16.
//  Copyright © 2016 ivansosnovik. All rights reserved.
//

import Foundation

protocol GameActions {
    
    var score: Int { get }
    var bestScore: Int { get }
    
    var deck: [String] { get }
    var rightFigureName: String? { get }
    
    func userChoose(index: Int)
    
    init(delegate: GameEvents, deckSize: Int)
    
}
