//
//  EmojiMemoryGame.swift
//  MemorizeStanford
//
//  Created by Pavel Otverchenko on 29.10.2021.
//

import SwiftUI

final class EmojiMemoryGame: ObservableObject {
    
    static let emojis = [["👁", "👀", "🫀", "🫁", "🧠", "👄", "🦷", "👅", "👂🏽"],
                         ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚜"],
                         ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️"]]
    
    static let themeNames = ["Body", "Cars", "Animals"]
    static let themeImagesNames = ["person", "car", "pawprint.fill"]
    
    var model: MemoryGame<String>

    @Published var selectedThemeIndex: Int = 0 {
        didSet {
            model.changeGameTheme(
                MemoryGame<String>.GameInformation(
                    themeName: EmojiMemoryGame.themeNames[selectedThemeIndex],
                    themeImageName: EmojiMemoryGame.themeImagesNames[selectedThemeIndex],
                    cardContent: EmojiMemoryGame.emojis[selectedThemeIndex]
                ),
                numberOfPairsOfCards: 9
            )
            publishedCards = model.visibleCards
        }
    }
    
    @Published var publishedCards: Array<MemoryGame<String>.Card>
    
    //MARK: - Initialisation -
    
    init(){
        let gameModel = MemoryGame<String>(
            numberOfPairsOfCards: 9,
            gameInformation: MemoryGame<String>.GameInformation(
                themeName: EmojiMemoryGame.themeNames.first!,
                themeImageName: EmojiMemoryGame.themeImagesNames.first!,
                cardContent: EmojiMemoryGame.emojis.first!
            )
        )
        model = gameModel
        publishedCards = gameModel.visibleCards
    }
    
    //MARK: - Intent(s) -
    
    func choose(_ card: MemoryGame<String>.Card) {
        let foundIndex = publishedCards.firstIndex(where: { $0.id == card.id })!
        publishedCards[foundIndex].isFaceUp.toggle()
    }
}
