//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Thierno Diallo on 11/17/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private  var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""


    
    var body: some View {
        
        ZStack {
            LinearGradient(colors: [.red, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap The Flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.black)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flaggTapped(number)
                        } label: {
                            Image(countries[number]) //will show random flags
                                .clipShape(.capsule)
                                .shadow(radius: 10)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                
                Text("Score: ???")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }.padding()
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is ???")
        }
    }
        
        func flaggTapped(_ number: Int) {
            if number == correctAnswer {
                scoreTitle = "Correct"
            } else {
                scoreTitle = "Wrong"
            }
            
            showingScore = true
        }
    
    func askQuestion() { //Needed to change the shuffle and potential answer
        countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
