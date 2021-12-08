//
//  GameBoardView.swift
//  MemorizeStanford
//
//  Created by Pavel Otverchenko on 27.10.2021.
//

import SwiftUI

struct GameBoardView: View {
    
    @ObservedObject var viewModel : EmojiMemoryGame
    var themeIndex: Int
    
    var body: some View {
        
        VStack {
            GameBoard(cards: viewModel.model[themeIndex].visibleCards, themeColor: viewModel.getThemeColor(atIndex: themeIndex)) { tappedCard in
                viewModel.choose(tappedCard, themeIndex: themeIndex)
            }
            
            Spacer()
            
            HStack {
                
                Text("Score: \(viewModel.model[themeIndex].score)")
                    .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    viewModel.startNewGameForModelAt(index: themeIndex)
                }, label: {
                    Text("New Game")
                        .frame(width: 200, height: 50)
                        .foregroundColor(.white)
                        .background(viewModel.getThemeColor(atIndex: themeIndex) ?? Color.red)
                        .cornerRadius(10)
                })
            }
        }
        .navigationTitle(viewModel.model[themeIndex].themeName)
        .padding()
    }
}

struct GameBoard: View {
    
    let cards: [MemoryGame<String>.Card]
    let themeColor: Color?
    let cardTapped: (MemoryGame<String>.Card) -> Void
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
                ForEach(cards) { card in
                    CardView(card: card, themeColor: themeColor ?? .gray)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            cardTapped(card)
                        }
                }
            }
        }
    }
}

struct CardView: View {
    
    let card: MemoryGame<String>.Card
    let themeColor: Color
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape
                    .stroke()
                    .fill()
                    .foregroundColor(.purple)
                
                Text(card.content)
                    .padding()
                    .foregroundColor(.pink)
                    .font(.title)
                    
            } else {
                shape
                    .fill()
                    .foregroundColor(themeColor)
            }
        }
        .opacity(card.isMatched ? 0 : 1)
    }
}


struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let model = EmojiMemoryGame()

        GameBoardView(viewModel: model, themeIndex: 0)
    }
}

