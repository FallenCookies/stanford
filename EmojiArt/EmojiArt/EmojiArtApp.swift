//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Vlad Zamaev on 26.12.2020.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: EmojiArtDocument())
        }
    }
}
