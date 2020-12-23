//
//  MemoryGame.swift
//  MemoryGame
//
//  Created by Vlad Zamaev on 22.12.2020.
//

import Foundation

struct MemoryGame<CardContent>{
    var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pariIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pariIndex)
            cards.append(Card(isFaceUp: true, isMatched: false, content: content, id: pariIndex * 2))
            cards.append(Card(isFaceUp: true, isMatched: false, content: content, id: pariIndex * 2 + 1 ))
        }
        cards.shuffle()
    }
    func index(of card: Card) -> Int{
        for index in 0..<self.cards.count {
            if self.cards[index].id == card.id{
                return index
            }
        }
        return 0
    }
    mutating func choose(card: Card){
        print("card chosen: \(card)")
        let chosenIndex: Int = self.index(of: card)
        self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp
    }
    struct Card: Identifiable {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
        var id: Int
        
    }
}

