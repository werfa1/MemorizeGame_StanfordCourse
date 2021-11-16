//
//  EmojiMemoryGame.swift
//  MemorizeStanford
//
//  Created by Pavel Otverchenko on 29.10.2021.
//

import SwiftUI

final class EmojiMemoryGame: ObservableObject {
    
    //MARK: - Static Properties -
    
    static let emojis = [["👁", "👀", "🫀", "🫁", "🧠", "👄", "🦷", "👅", "👂🏽"],
                         ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚜"],
                         ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️"]]
    
    static let themeNames = ["Body", "Cars", "Animals"]
    static let themeImagesNames = ["person", "car", "pawprint.fill"]
    
    //MARK: - Published Properties -
    
    @Published var model: MemoryGame<String>
    
    //MARK: - Properties -
    
    private var numberOfPairsOfCards: Int = 5

    var selectedThemeIndex: Int = 0 {
        didSet {
            model.changeGameTheme(
                MemoryGame<String>.GameInformation(
                    themeName: EmojiMemoryGame.themeNames[selectedThemeIndex],
                    themeImageName: EmojiMemoryGame.themeImagesNames[selectedThemeIndex],
                    cardContent: EmojiMemoryGame.emojis[selectedThemeIndex]
                ),
                numberOfPairsOfCards: numberOfPairsOfCards
            )
        }
    }
    
    var publishedCards: Array<MemoryGame<String>.Card> {
        return model.visibleCards
    }
    
    //MARK: - Initialisation -
    
    init(){
        let gameModel = MemoryGame<String>(
            numberOfPairsOfCards: numberOfPairsOfCards,
            gameInformation: MemoryGame<String>.GameInformation(
                themeName: EmojiMemoryGame.themeNames.first!,
                themeImageName: EmojiMemoryGame.themeImagesNames.first!,
                cardContent: EmojiMemoryGame.emojis.first!
            )
        )
        model = gameModel
    }
    
    //MARK: - Intent(s) -
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
