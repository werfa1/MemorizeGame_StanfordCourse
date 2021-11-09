//
//  ContentView.swift
//  MemorizeStanford
//
//  Created by Pavel Otverchenko on 27.10.2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = EmojiMemoryGame()
    
    var body: some View {
        TabView(selection: $viewModel.selectedThemeIndex) {
            
            ForEach(0..<EmojiMemoryGame.emojis.count) { sectionIndex in
                GameBoard(cards: viewModel.publishedCards) { tappedCard in
                    viewModel.choose(tappedCard)
                }
                .padding()
                .tabItem {
                    Label("Halloween", systemImage: "person")
                        .foregroundColor(.blue)
                }
            }
        }
        .navigationBarTitleDisplayMode(.large)
    }
}

struct GameBoard: View {
    
    var cards      : [MemoryGame<String>.Card]
    var cardTapped : (MemoryGame<String>.Card) -> Void
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(cards) { card in
                    CardView(card: card)
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
                    .font(.largeTitle)
                    
            } else {
                shape
                    .fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
