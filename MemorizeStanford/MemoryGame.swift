//
//  MemoryGame.swift
//  MemorizeStanford
//
//  Created by Pavel Otverchenko on 29.10.2021.
//

import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    //MARK: - Properties -
    
    var themeName: String!
    var themeImageName: String!
    var numberOfPairs: Int!
    
    private (set) var visibleCards: [Card]
    
    private var indexOfFaceUpCard: Int?
    
    //MARK: - Nested Structures -
    
    struct Card : Identifiable {
        var id : Int
        var isFaceUp : Bool = false
        var isMatched : Bool = false
        var content : CardContent
    }
    
    struct GameInformation {
        let themeName : String
        let themeImageName : String
        let cardContent : [String]
        let numberOfPairs: Int
    }
    
    //MARK: - Initialisation -
    
    init(gameInformation: Theme) {
        
        visibleCards = [Card]()
        
        setGameTheme(gameInformation)
    }
}

//MARK: - Methods -

extension MemoryGame {
    
    mutating func setGameTheme(_ gameInfo: Theme) {
        
        visibleCards = []
        
        themeName = gameInfo.themeName
        themeImageName = gameInfo.themeImageName
        numberOfPairs = gameInfo.numberOfPairs
        
        for contentId in 0..<numberOfPairs {
            visibleCards.append(Card(id: 2 * contentId, content: gameInfo.cardContent[contentId] as! CardContent))
            visibleCards.append(Card(id: 2 * contentId + 1, content: gameInfo.cardContent[contentId] as! CardContent))
        }
        
        visibleCards.shuffle()
    }
    
    /// Implements the process of picking the card
    mutating func choose(_ card: Card) {
        guard let cardIndex = index(of: card) else { return }
        guard !visibleCards[cardIndex].isFaceUp else { return }
        if let potentialMatchIndex = indexOfFaceUpCard {
            if visibleCards[cardIndex].content == visibleCards[potentialMatchIndex].content {
                visibleCards[cardIndex].isMatched = true
                visibleCards[potentialMatchIndex].isMatched = true
            }
            indexOfFaceUpCard = nil
        } else {
            visibleCards.indices.forEach { cardIndex in
                visibleCards[cardIndex].isFaceUp = false
            }
            indexOfFaceUpCard = cardIndex
        }
        visibleCards[cardIndex].isFaceUp.toggle()
    }
    
    func index(of card: Card) -> Int? {
        for index in 0..<visibleCards.count {
            if visibleCards[index].id == card.id {
                return index
            }
        }
        return nil
    }
}
