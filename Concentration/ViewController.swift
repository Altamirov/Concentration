//
//  ViewController.swift
//  Concentration
//
//  Created by Наиб Альтамиров on 17.05.2022.
//

import UIKit

class ViewController: UIViewController {
   
   private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
            return (cardButtons.count + 1) / 2
    }
    
   private(set) var flipCount = 0 {
        didSet {
            flipCountLable.text = "Flips: \(flipCount)"
        }
    }
    @IBOutlet private weak var flipCountLable: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("error!!!")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? .orange.withAlphaComponent(0): .orange
            }
        }
    }
    private var emojiChoices = ["🐁","🕊","🪱","🦋","🐌","🪰","🦄","🦅","🦖"]

    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 { 
                
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }

}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int( arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int( arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}
