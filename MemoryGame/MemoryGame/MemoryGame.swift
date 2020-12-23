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
            cards.append(Card(isFaceUp: false, isMatched: false, content: content, id: pariIndex * 2))
            cards.append(Card(isFaceUp: false, isMatched: false, content: content, id: pariIndex * 2 + 1 ))
        }
    }
    func choose(card: Card){
        print("card chosen: \(card)")
    }
    struct Card: Identifiable {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
        var id: Int
        
    }
}

