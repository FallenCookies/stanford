//
//  OptionalImage.swift
//  EmojiArt
//
//  Created by Vlad Zamaev on 28.12.2020.
//

import SwiftUI

struct OptionalImage: View {
    var uiImage: UIImage?
    
    var body: some View {
        Group {
            if uiImage != nil {
                Image(uiImage: uiImage!)
            }
        }
    }
}

