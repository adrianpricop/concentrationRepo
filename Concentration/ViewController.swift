//
//  ViewController.swift
//  Concentration
//
//  Created by apple on 23/05/2018.
//  Copyright © 2018 wolfpack. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)

    var theme = Int()

    var emojiChoices = [String]()

    var colors = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomeTheme()
        uppdateViewFromModel()
    }
    
    @IBOutlet weak var scoreBord: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet var newGameButton: [UIButton]!
    
    @IBOutlet var gameBackground: UIView!
    
    @IBAction func newGame(_ sender: UIButton)
    {
        randomeTheme()
        game.resetGame()
        uppdateViewFromModel()
        emoji.removeAll()
    }
    
    @IBAction func touchCard(_ sender: UIButton)
    {
        if let cardNumber = cardButtons.index(of: sender)
        {
            game.chooseCard(at: cardNumber)
            uppdateViewFromModel()
        }else
        {
            print("stupid")
        }
    }
    
    func uppdateViewFromModel()
    {
        for index in newGameButton.indices
        {
            let gameButton = newGameButton[index]
            gameButton.setTitleColor((colors[1] as! UIColor), for: UIControlState.normal)
        }
        for index in cardButtons.indices
        {
            
            let button = cardButtons[index]
            let card = game.cards[index]
            let score = game.score
            
            
            
            gameBackground.backgroundColor = (colors[0] as! UIColor)
            scoreBord.textColor = (colors[1] as! UIColor)
            scoreBord.text = "score: \(score)"
            scoreBord.sizeToFit()
            
            
            
            if card.isFaceUp
            {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            }else
            {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor =  card.isMatches ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : (colors[1] as! UIColor)
                
            }
        }
    }
    
    var emojiTheme = [0:["🏀","🏈","⚽️","⚾️","🎾","🏐","🏓","🏒","🏑","🏏","🎱","🛶"],1:["🐅","🦓","🦍","🐘","🦏","🦒","🐃","🐊","🕊","🐺","🦉","🦄"],2:["🌍","🌕","☄️","🌜","💥","⚡️","🔥","🌪","☀️","🌈","❄️","💧"],3:["😃","😇","😍","😎","🤪","😭","😡","🤮","🤐","🤠","😴","🤕"]]
    
    var colorTheme = [0:[#colorLiteral(red: 0.01925091818, green: 0.01541900821, blue: 0.008230157197, alpha: 1),#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)],1:[#colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)],2:[#colorLiteral(red: 0.9919437766, green: 0.9924803376, blue: 0.995811522, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)],3:[#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)]]
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String
    {
        if emoji[card.identifier] == nil, (emojiChoices.count) > 0
        {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    func randomeTheme()
    {
        theme = Int(arc4random_uniform(UInt32(colorTheme.count)))
        emojiChoices = emojiTheme[theme]!
        colors = colorTheme[theme]!
    }

}

