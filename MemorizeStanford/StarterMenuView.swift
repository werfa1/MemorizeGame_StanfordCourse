//
//  StarterMenuView.swift
//  MemorizeStanford
//
//  Created by Pavel Otverchenko on 26.11.2021.
//

import SwiftUI

struct StarterMenuView: View {
    
    var viewModel: EmojiMemoryGame
    var themes: [Theme]
    
    @State private var isThemeChosen = false
    
    var body: some View {
        
        NavigationView {
            List(themes, id: \.id) { theme in
                
                NavigationLink {
                    GameBoardView(viewModel: viewModel)
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

struct StarterMenuView_Previews: PreviewProvider {
    
    static var previews: some View {
        let game = EmojiMemoryGame()
        StarterMenuView(viewModel: game, themes: [])
    }
}
