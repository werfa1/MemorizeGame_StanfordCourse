//
//  EmojiMemoryGame.swift
//  MemorizeStanford
//
//  Created by Pavel Otverchenko on 29.10.2021.
//

import SwiftUI

final class EmojiMemoryGame: ObservableObject {
    
    static let emojis = [["👁", "👀", "🫀", "🫁", "🧠", "👄", "🦷", "👅", "👂🏽"],
                         ["💀", "☠️", "👽", "👾", "🤖", "🎃", "😺", "😡", "🥳"],
                         ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚜"],
                         ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️"]]
    
    @Published var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: 4) { index in emojis[index] }

    @Published var selectedThemeIndex: Int = 0 { didSet {
        print("sekected index: \(selectedThemeIndex)")
        let emojiTheme = EmojiMemoryGame.emojis[selectedThemeIndex]
        publishedCards = emojiTheme.enumerated().map { index, emoji in MemoryGame.Card(id: Int.random(in: 0..<228), isFaceUp: false, isMatched: false, content: emoji) }
    }}
    @Published var publishedCards: Array<MemoryGame<String>.Card> = []
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    //MARK: - Intent(s) -
    
    func choose(_ card: MemoryGame<String>.Card) {
        let foundIndex = publishedCards.firstIndex(where: { $0.id == card.id })!
        publishedCards[foundIndex].isFaceUp.toggle()
    }
}
