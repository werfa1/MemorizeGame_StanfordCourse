//
//  EmojiMemoryGame.swift
//  MemorizeStanford
//
//  Created by Pavel Otverchenko on 29.10.2021.
//

import SwiftUI

final class EmojiMemoryGame: ObservableObject {
    
    //MARK: - Static Properties -
    
    static let allThemes = [
        Theme(
            id: 0,
            themeName: "Body",
            themeImageName: "person",
            cardContent: ["👁", "👀", "🫀", "🫁", "🧠", "👄", "🦷", "👅", "👂🏽"],
            numberOfPairs: 9,
            color: "orange"
        ),
        Theme(
            id: 1,
            themeName: "Cars",
            themeImageName: "car",
            cardContent: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚜"],
            numberOfPairs: 8,
            color: "purple"
        ),
        Theme(
            id: 2,
            themeName: "Animals",
            themeImageName: "pawprint.fill",
            cardContent: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️"],
            numberOfPairs: 6,
            color: "pink"
        ),
        Theme(
            id: 3,
            themeName: "Flowers",
            themeImageName: "leaf",
            cardContent: ["🌴", "🌿", "🍀", "🪴", "🍂", "🍁", "🍄", "🌾", "🌸"],
            numberOfPairs: 7,
            color: "green"
        ),
        Theme(
            id: 4,
            themeName: "Weather",
            themeImageName: "cloud",
            cardContent: ["⚡️", "☄️", "🌪", "🌈", "☀️", "☁️", "❄️", "🌧", "🌊"],
            numberOfPairs: 9,
            color: "yellow"
        ),
        Theme(
            id: 5,
            themeName: "Food",
            themeImageName: "cart",
            cardContent: ["🍏", " 🍐", "🍌", "🍓", "🍉", "🥥", "🥑", "🫒", "🍑"],
            numberOfPairs: 5,
            color: "blue"
        )
    ]
    
    //MARK: - Published Properties -
    
    @Published var model: MemoryGame<String>
    
    //MARK: - Properties -
    
    private var numberOfPairsOfCards: Int = 5
    
    var selectedThemeIndex: Int = 0 {
        didSet {
            model.setGameTheme(
                Theme (
                    id: EmojiMemoryGame.allThemes[selectedThemeIndex].id,
                    themeName: EmojiMemoryGame.allThemes[selectedThemeIndex].themeName,
                    themeImageName: EmojiMemoryGame.allThemes[selectedThemeIndex].themeImageName,
                    cardContent: EmojiMemoryGame.allThemes[selectedThemeIndex].cardContent,
                    numberOfPairs: EmojiMemoryGame.allThemes[selectedThemeIndex].numberOfPairs,
                    color: EmojiMemoryGame.allThemes[selectedThemeIndex].color
                )
            )
        }
    }
    
    var publishedCards: Array<MemoryGame<String>.Card> {
        return model.visibleCards
    }
    
    //MARK: - Initialisation -
    
    init(){
        let gameModel = MemoryGame<String>(
            gameInformation: Theme (
                id: EmojiMemoryGame.allThemes[selectedThemeIndex].id,
                themeName: EmojiMemoryGame.allThemes[selectedThemeIndex].themeName,
                themeImageName: EmojiMemoryGame.allThemes[selectedThemeIndex].themeImageName,
                cardContent: EmojiMemoryGame.allThemes[selectedThemeIndex].cardContent,
                numberOfPairs: EmojiMemoryGame.allThemes[selectedThemeIndex].numberOfPairs,
                color: EmojiMemoryGame.allThemes[selectedThemeIndex].color
            )
        )
        model = gameModel
    }
    
    //MARK: - Intent(s) -
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        let newThemeIndex = Int.random(in: 0..<EmojiMemoryGame.allThemes.count)
        model.setGameTheme(EmojiMemoryGame.allThemes[newThemeIndex])
    }
    
    func getThemeColor() -> Color? {
        let currentTheme = EmojiMemoryGame.allThemes[selectedThemeIndex]
        switch currentTheme.color {
        case "pink" :
            return .pink
        case "blue":
            return .blue
        case "red":
            return .red
        case "green":
            return .green
        case "purple":
            return .purple
        case "yellow":
            return .yellow
        case "orange":
            return .orange
        default:
            return nil
        }
    }
}
