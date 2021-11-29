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
    var themeColor: String!
    
    private (set) var visibleCards: [Card]
    private var alreadySeenCards: [Card] = []
    
    private var indexOfFaceUpCard: Int?
    
    private var score = 0 {
        didSet {
            print(score)
        }
    }
    
    //MARK: - Nested Structures -
    
    struct Card : Identifiable {
        let id: Int
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
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
        indexOfFaceUpCard = nil
        
        themeName = gameInfo.themeName
        themeImageName = gameInfo.themeImageName
        if gameInfo.numberOfPairs <= gameInfo.cardContent.count {
            numberOfPairs = gameInfo.numberOfPairs
        } else {
            numberOfPairs = gameInfo.cardContent.count
        }
        
        themeColor = gameInfo.color
        
        let shuffledCardContent = gameInfo.cardContent.shuffled()
        
        for contentId in 0..<numberOfPairs {
            visibleCards.append(Card(id: 2 * contentId, content: shuffledCardContent[contentId] as! CardContent))
            visibleCards.append(Card(id: 2 * contentId + 1, content: shuffledCardContent[contentId] as! CardContent))
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
                score += 2
            } else {
                score -= 1
            }
            
            indexOfFaceUpCard = nil
        } else {
            visibleCards.indices.forEach { cardIndex in
                visibleCards[cardIndex].isFaceUp = false
            }
            indexOfFaceUpCard = cardIndex
            
        }
        alreadySeenCards.append(visibleCards[cardIndex])
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
