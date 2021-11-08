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
    
    @Published private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: 4) { index in
        return emojis[index]
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    //MARK: - Intent(s) -
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
