//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Thierno Diallo on 11/17/24.
//

import SwiftUI

struct ContentView: View {
    
    var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        
        ZStack {
            LinearGradient(colors: [.white, .red], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap The Flag of")
                    Text(countries[correctAnswer])
                }
                
                ForEach(0..<4) { country in
                    Button {
                        
                    } label: {
                        Image(countries[country]) //will show random flags
                    }
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
