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
                            withAnimation (.linear(duration: 0.75)){
                                viewModel.choose(card: card)
                            }
                        }
                        .padding(5)
                    }
                .padding()
                .foregroundColor(viewModel.color)
                .font(Font.largeTitle)
                Button(action: {
                    withAnimation(.easeInOut){
                        viewModel.startNewGame()
                    }
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
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
     
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaning)){
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View{
        if card.isFaceUp || !card.isMatched {
            ZStack{
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(-animatedBonusRemaining * 360 - 90), clockwise: true)
                            .onAppear{
                                self.startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(-card.bonusRemaining * 360 - 90), clockwise: true)
                    }
                }
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
            
        }
    }
    // - Drawing Constants
    private func  fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            EmojiMemoryGameView(viewModel: EmojiMemoryGame())
        }
    }
}
