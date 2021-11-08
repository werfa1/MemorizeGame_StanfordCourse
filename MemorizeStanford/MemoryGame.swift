//
//  MemoryGame.swift
//  MemorizeStanford
//
//  Created by Pavel Otverchenko on 29.10.2021.
//

import Foundation

struct MemoryGame<CardContent> {
    
    //MARK: - Properties -
    
    private (set) var cards: [Card]
    
    struct Card : Identifiable {
        var id        : Int
        var isFaceUp  : Bool = false
        var isMatched : Bool = false
        var content   : CardContent
    }
    
    //MARK: - Initialisation -
    
    init(numberOfPairsOfCards: Int, createCardContent: ((Int) -> [CardContent])) {
        
        cards = Array<Card>()
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(id: 2 * pairIndex, content: content[pairIndex]))
            cards.append(Card(id: 2 * pairIndex + 1, content: content[pairIndex]))
        }
    }
}

//MARK: - Methods -

extension MemoryGame {
    
    mutating func choose(_ card: Card) {
        let cardIndex = index(of: card)
        cards[cardIndex].isFaceUp.toggle()
    }
    
    func index(of card: Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0
    }
}
