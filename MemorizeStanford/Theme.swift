//
//  Theme.swift
//  MemorizeStanford
//
//  Created by Pavel Otverchenko on 25.11.2021.
//

import Foundation

struct Theme : Identifiable {
    let id: Int
    let themeName: String
    let themeImageName: String
    let cardContent : [String]
    let numberOfPairs: Int
    let color: String
}
