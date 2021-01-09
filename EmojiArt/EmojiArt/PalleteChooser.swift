//
//  PalleteChooser.swift
//  EmojiArt
//
//  Created by Vlad Zamaev on 02.01.2021.
//

import SwiftUI

struct PalleteChooser: View {
    @ObservedObject var document: EmojiArtDocument
    
    @Binding var chosenPalette: String
    @State private var showPaletteEditor = false
    
    var body: some View {
        HStack{
            Stepper(onIncrement: {
                self.chosenPalette = self.document.palette(after: self.chosenPalette)
            }, onDecrement: {
                self.chosenPalette = self.document.palette(before: self.chosenPalette)
            }, label: {EmptyView()})
            Text(self.document.paletteNames[self.chosenPalette] ?? "")
            Image(systemName: "keyboard").imageScale(.large)
                .onTapGesture {
                    self.showPaletteEditor = true
                }
                .sheet(isPresented: $showPaletteEditor){
                    PaletteEditor(chosenPalette: self.$chosenPalette, isShowing: $showPaletteEditor)
                        .environmentObject(self.document)
                        .frame(minWidth: 300, minHeight: 500)
                }
        }
        .fixedSize(horizontal: true, vertical: false)
    }
}

struct PaletteEditor: View {
    @EnvironmentObject var document: EmojiArtDocument
    @Binding var chosenPalette: String
    @Binding var isShowing: Bool
    @State private var paletteName: String = ""
    @State private var emojisToAdd: String = ""
    
    var body: some View {
        VStack(spacing: 0){
            ZStack{
                Text("Palette Editor")
                    .font(.headline).padding()
                HStack{
                    Spacer()
                    Button(action: {
                        self.isShowing = false
                    }, label: {Text("Done")}).padding()
                }
            }
            Divider()
            Form{
                Section {
                    TextField("Palette Name", text: $paletteName, onEditingChanged: {
                        began in
                        if !began {
                            self.document.renamePalette(self.chosenPalette, to: self.paletteName)
                        }
                    })
                        .padding()
                    TextField("Add Emoji", text: $emojisToAdd, onEditingChanged: {
                        began in
                        if !began {
                            self.chosenPalette = self.document.addEmoji(self.emojisToAdd, toPalette: self.chosenPalette)
                            self.emojisToAdd = ""
                        }
                    })
                        .padding()
                }
                Grid(chosenPalette.map { String($0)}, id: \.self) { emoji in
                    Text(emoji).font(Font.system(size: self.fontSize))
                        .onTapGesture {
                            self.chosenPalette = self.document.removeEmoji(emoji,fromPalette: self.chosenPalette)
                        }
                }
                .frame(height: self.height)
            }
            Spacer()
        }
        .onAppear{
            self.paletteName = self.document.paletteNames[self.chosenPalette] ?? ""
        }
    }
    
    let fontSize: CGFloat = 40.0
    var height: CGFloat{
        CGFloat((chosenPalette.count - 1) / 6) * 70 + 70
    }
}

struct PalleteChooser_Previews: PreviewProvider {
    static var previews: some View {
        PalleteChooser(document: EmojiArtDocument(), chosenPalette: Binding.constant(""))
    }
}
