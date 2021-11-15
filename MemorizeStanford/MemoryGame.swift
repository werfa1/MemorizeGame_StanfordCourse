//
//  MemoryGame.swift
//  MemorizeStanford
//
//  Created by Pavel Otverchenko on 29.10.2021.
//

import Foundation



struct MemoryGame<CardContent> {
    
    //MARK: - Properties -
    
    var themeName      : String!
    var themeImageName : String!
    
    private (set) var visibleCards: [Card]
    
    struct Card : Identifiable {
        var id        : Int
        var isFaceUp  : Bool = false
        var isMatched : Bool = false
        var content   : CardContent
    }
    
    struct GameInformation {
        let themeName      : String
        let themeImageName : String
        let cardContent    : [CardContent]
    }
    
    //MARK: - Initialisation -
    
    init(numberOfPairsOfCards: Int, gameInformation: GameInformation) {
        
        visibleCards = [Card]()
        
        changeGameTheme(gameInformation, numberOfPairsOfCards: numberOfPairsOfCards)
    }
}

//MARK: - Methods -

extension MemoryGame {
    
    mutating func changeGameTheme(_ gameInfo: GameInformation, numberOfPairsOfCards: Int) {
        
        visibleCards = []
        
        themeName = gameInfo.themeName
        themeImageName = gameInfo.themeImageName
        
        for contentId in 0..<numberOfPairsOfCards {
            visibleCards.append(Card(id: 2 * contentId, content: gameInfo.cardContent[contentId]))
            visibleCards.append(Card(id: 2 * contentId + 1, content: gameInfo.cardContent[contentId]))
        }
        
        visibleCards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        let cardIndex = index(of: card)
        visibleCards[cardIndex].isFaceUp.toggle()
    }
    
    func index(of card: Card) -> Int {
        for index in 0..<visibleCards.count {
            if visibleCards[index].id == card.id {
                return index
            }
        }
        return 0
    }
}
