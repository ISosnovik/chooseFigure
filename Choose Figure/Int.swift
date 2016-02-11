//
//  Int.swift
//  Choose Figure
//
//  Created by Ivan Sosnovik on 11.02.16.
//  Copyright © 2016 ivansosnovik. All rights reserved.
//

import Foundation

extension Int{
    // generate random value from the interval
    static func random(range: Range<Int> ) -> Int
    {
        var offset = 0
        if range.startIndex < 0   // allow negative ranges
        {
            offset = abs(range.startIndex)
        }
        
        let mini = UInt32(range.startIndex + offset)
        let maxi = UInt32(range.endIndex   + offset)
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
    
    // generate array with unique random values
    static func uniqueRandoms(numberOfRandoms: Int, minNum: Int, maxNum: Int) -> [Int] {
        
        var randoms: [Int] = []
        if maxNum - minNum + 1 < numberOfRandoms {
            return randoms
        }
        
        while randoms.count < numberOfRandoms {
            let randomNumber = Int.random(minNum...maxNum)
            if !randoms.contains(randomNumber) {
                randoms.append(randomNumber)
            }
        }
        
        return randoms
    }
    
    // generate array of values
    static func randoms(numberOfRandoms: Int, minNum: Int, maxNum: Int, forbiddenValues: [Int]) -> [Int] {
        // if there is any valid values
        var valid = false
        for value in minNum...maxNum {
            if !forbiddenValues.contains(value) {
                valid = true
                break
            }
        }
        if !valid {
            return [] 
        }
        var randoms: [Int] = []
        
        while randoms.count < numberOfRandoms {
            let randomNumber = Int.random(minNum...maxNum)
            if !forbiddenValues.contains(randomNumber) {
                randoms.append(randomNumber)
            }
        }
        
        return randoms
    }
}