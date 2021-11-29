//
//  StarterMenuView.swift
//  MemorizeStanford
//
//  Created by Pavel Otverchenko on 26.11.2021.
//

import SwiftUI

struct StarterMenuView: View {
    
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        
        NavigationView {
            List(EmojiMemoryGame.allThemes, id: \.id) { theme in
                
                NavigationLink {
                    GameBoardView(viewModel: viewModel, themeIndex: theme.id)
                } label: {
                    HStack {
                        Label(theme.themeName, systemImage: theme.themeImageName)
                    }
                }
            }
            .navigationTitle("Memorize!")
        }
    }
}
