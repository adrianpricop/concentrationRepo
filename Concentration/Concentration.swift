//
//  Concentration.swift
//  Concentration
//
//  Created by apple on 24/05/2018.
//  Copyright © 2018 wolfpack. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
//    var shuffledCards = [Card]()
    
    var indexOfTheFacedUpCard: Int?
    
    var score = 0
    
    var scorePoints = [10,1]
    
    var repeatScoreuppdate = true
    
    var scoreTimer: Timer!
    
    @objc func uppdateScorePoints()
    {
        if scorePoints[0] > 2
        {
            scorePoints[0] -= 2
            scorePoints[1] += 1
        }else
        {
            scoreTimer.invalidate()
        }
    }
    
    func chooseCard(at index: Int)
    {
        if !cards[index].isMatches
        {
            if let matchIndex = indexOfTheFacedUpCard, matchIndex != index
            {
                if cards[matchIndex].identifier == cards[index].identifier
                {
                    cards[matchIndex].isMatches = true
                    cards[index].isMatches = true
                    score += scorePoints[0]
                }else
                {
                    if cards[matchIndex].numFlips > 1 || cards[index].numFlips > 1
                    {
                        if cards[matchIndex].numFlips > 1 && cards[index].numFlips > 1
                        {
                            score -= 2*scorePoints[1]
                        }else
                        {
                            score -= scorePoints[1]
                        }
                    }
                }
                cards[matchIndex].numFlips += 1
                cards[index].numFlips += 1
                cards[index].isFaceUp = true
                indexOfTheFacedUpCard = nil
            }else
            {
                for flipDownIndex in cards.indices
                {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfTheFacedUpCard = index
            }
        }
    }

    
    init(numberOfPairsOfCards: Int)
    {
        for _ in 0..<numberOfPairsOfCards
        {
            let card = Card()
            cards += [card, card]
        }
        shuffleCards()
        
    }
    
    func shuffleCards()
    {
        var shuffledCards = [Card]()
        scoreTimer = Timer.scheduledTimer(timeInterval: 7.5, target: self , selector: #selector(uppdateScorePoints), userInfo: nil, repeats: true)
        for _ in 0..<cards.count
        {
            let randomIdex = Int(arc4random_uniform(UInt32(cards.count)))
            shuffledCards += [cards[randomIdex]]
            cards.remove(at: randomIdex)
        }
        cards = shuffledCards
        shuffledCards.removeAll()
    }
    
    func resetGame()
    {
        for resetIndex in cards.indices
        {
            cards[resetIndex].isFaceUp = false
            cards[resetIndex].isMatches = false
            cards[resetIndex].numFlips = 0
        }
        scorePoints = [10,1]
        score = 0
        shuffleCards()
    }
}
