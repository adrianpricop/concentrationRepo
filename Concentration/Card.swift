//
//  Card.swift
//  Concentration
//
//  Created by apple on 24/05/2018.
//  Copyright © 2018 wolfpack. All rights reserved.
//

import Foundation

struct Card
{
    
    var isFaceUp = false
    var isMatches = false
    var numFlips = 0
    var identifier: Int
    
    static var identifierFactori = 0
    
    static func getUnoqueIdentifier() -> Int
    {
        identifierFactori += 1
        return identifierFactori
    }
    
    init()
    {
        self.identifier = Card.getUnoqueIdentifier()
    }
}
