//
//  EmojiMemoryGame.swift
//  MemoryGame
//
//  Created by Vlad Zamaev on 22.12.2020.
//

import SwiftUI
import Foundation

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    static func createMemoryGame() -> MemoryGame<String>{
        
        let theme = getTheme()
        return MemoryGame<String>(numberOfPairsOfCards: theme.cardNumbers,themeName: theme.name, color: theme.color) { pairIndex in
            return theme.content[Int.random(in: 0..<theme.content.count)]
        }
    }
    
    var cards: Array<MemoryGame<String>.Card>{
        model.cards
    }
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
    var color: Color {
        model.color
    }
    var theme: String {
        model.themeName
    }
    func startNewGame(){
        model = EmojiMemoryGame.createMemoryGame()
    }
    static func getTheme() -> Theme {
        var themes = [Theme]()
        themes.append(Theme(name: "Halloween",content: ["👻", "🎃", "💀","👽"],color: Color(.orange) ))
        themes.append(Theme(name: "Sport",content: ["🥇", "🏂", "⚽️","🏈"],color: Color(.green) ))
        themes.append(Theme(name: "City",content: ["🏭", "🏢", "🕍","🏥"],color: Color(.blue) ))
        return themes[Int.random(in: 0..<themes.count)]
    }
    
}

struct Theme {
    var name: String
    var content: [String]
    var cardNumbers: Int {
        Int.random(in: 2..<content.count)
    }
    var color: Color
}
