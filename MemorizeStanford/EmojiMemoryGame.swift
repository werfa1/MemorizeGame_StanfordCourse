//
//  EmojiMemoryGame.swift
//  MemorizeStanford
//
//  Created by Pavel Otverchenko on 29.10.2021.
//

import SwiftUI

final class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
    
    //MARK: - Static Properties -
    
    static let allThemes = [
        Theme(
            id: 0,
            themeName: "Body",
            themeImageName: "person",
            cardContent: ["👁", "👀", "🫀", "🫁", "🧠", "👄", "🦷", "👅", "👂🏽"],
            numberOfPairs: 15,
            color: "red"
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
            cardContent: ["🍏", "🍆", "🍌", "🍓", "🍉", "🥥", "🥑", "🫒", "🍑"],
            numberOfPairs: 5,
            color: "blue"
        )
    ]
    
    //MARK: - Published Properties -
    
    @Published var model = [MemoryGame<String>]()
    
    //MARK: - Properties -
    
    private var numberOfPairsOfCards = 5
    
    var selectedThemeIndex = 0 {
        didSet {
            model[selectedThemeIndex].setGameTheme(EmojiMemoryGame.allThemes[selectedThemeIndex])
        }
    }
    
    //MARK: - Initialisation -
    
    init(){
        for index in EmojiMemoryGame.allThemes.indices {
            model.append(MemoryGame<String>(gameInformation: EmojiMemoryGame.allThemes[index]))
        }
    }
    
    //MARK: - Intent(s) -
    
    func choose(_ card: Card, themeIndex: Int) {
        model[themeIndex].choose(card)
    }
    
    func startNewGameForModelAt(index: Int) {
        let newThemeIndex = Int.random(in: 0..<EmojiMemoryGame.allThemes.count)
        model[index].setGameTheme(EmojiMemoryGame.allThemes[newThemeIndex])
    }
    
    func getThemeColor(atIndex index: Int) -> Color? {
        let currentThemeColor = model[index].themeColor
        switch currentThemeColor {
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
