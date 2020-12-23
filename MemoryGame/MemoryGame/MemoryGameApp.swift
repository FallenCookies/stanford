//
//  MemoryGameApp.swift
//  MemoryGame
//
//  Created by Vlad Zamaev on 22.12.2020.
//

import SwiftUI

@main
struct MemoryGameApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: EmojiMemoryGame())
        }
    }
}
