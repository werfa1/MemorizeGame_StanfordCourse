//
//  ContentView.swift
//  MemorizeStanford
//
//  Created by Pavel Otverchenko on 27.10.2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel : EmojiMemoryGame
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
            .padding()
        }
        .padding()
        .font(.largeTitle)
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
            .preferredColorScheme(.dark)
    }
}
