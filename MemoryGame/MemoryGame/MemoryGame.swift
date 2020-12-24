//
//  MemoryGame.swift
//  MemoryGame
//
//  Created by Vlad Zamaev on 22.12.2020.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    var themeName: String
    var color: Color
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.only
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    init(numberOfPairsOfCards: Int,themeName: String, color: Color, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        self.themeName = themeName
        self.color = color
        for pariIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pariIndex)
            cards.append(Card(isFaceUp: false, isMatched: false, content: content, id: pariIndex * 2))
            cards.append(Card(isFaceUp: false, isMatched: false, content: content, id: pariIndex * 2 + 1 ))
        }
        cards.shuffle()
    }

    mutating func choose(card: Card){
        print("card chosen: \(card)")
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
                if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
            }else{
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            self.cards[chosenIndex].isFaceUp = true
        }
        
    }
   
    
    struct Card: Identifiable {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
        var id: Int
        
    }
}

