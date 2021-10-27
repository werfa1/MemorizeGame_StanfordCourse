//
//  ContentView.swift
//  MemorizeStanford
//
//  Created by Pavel Otverchenko on 27.10.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .stroke()
                .padding()
                .foregroundColor(.purple)
            
            Text("Hello, world!")
                .padding()
                .foregroundColor(.pink)
        }
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
