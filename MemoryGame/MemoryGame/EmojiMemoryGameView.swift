//
//  ContentView.swift
//  MemoryGame
//
//  Created by Vlad Zamaev on 22.12.2020.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    var body: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text(viewModel.theme)
                        .foregroundColor(viewModel.color)
                        .padding()
                    Spacer()
                    Text("some score")
                        .foregroundColor(.white)
                        .padding()
                }
                Grid(items: viewModel.cards){
                        card in CardView(card: card).onTapGesture {
                            viewModel.choose(card: card)
                        }
                        .padding(5)
                    }
                .padding()
                .foregroundColor(viewModel.color)
                .font(Font.largeTitle)
                Button(action: {
                    viewModel.startNewGame()
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 50, alignment: .center)
                            .padding()
                        Text("New game")
                            .foregroundColor(.white)
                    }
                })
            }
        }
    }
}

struct CardView: View{
    var card: MemoryGame<String>.Card
    var body: some View{
        GeometryReader{ geometry in
            ZStack{
                if card.isFaceUp{
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                    Text(card.content)
                }else{
                    if !card.isMatched{
                        RoundedRectangle(cornerRadius: cornerRadius)
                        .fill()
                    }
                }
            }
            .font(Font.system(size: min(geometry.size.width, geometry.size.height) * fontScaleFactor))
        }
    }
    // - Drawing Constants
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    let fontScaleFactor: CGFloat = 0.75
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
