//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Thierno Diallo on 11/17/24.
//

import SwiftUI

struct ContentView: View {
    
    static let allCountries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"] //Created the data to be static so it can accessed directly and not through an instance.
    
    
    @State private var countries = allCountries.shuffled()

    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var score = 0
    
    @State private var questionCounter = 1 //Track the attempts

    @State private var showingResults = false // Boolean for the alert


    
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
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Text("Attempts: \(questionCounter)")
                    .foregroundStyle(.white)
                    .font(.caption.bold())
                
                Spacer()
                
            }.padding()
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game over!", isPresented: $showingResults) {
            Button("Start Again", action: restart)
        } message: {
            Text("Your final score was \(score).")
        }
    }
        
        func flaggTapped(_ number: Int) {
            if number == correctAnswer {
                scoreTitle = "Correct"
                score += 1
            } else {
                let needsThe = ["UK", "US"]
                let theirAnswer = countries[number]

                if needsThe.contains(theirAnswer) {
                    scoreTitle = "Wrong! That's the flag of the \(theirAnswer)."
                } else {
                    scoreTitle = "Wrong! That's the flag of \(theirAnswer)."
                }
            }
            
            if questionCounter == 8 {
                showingResults = true
            } else {
                
                showingScore = true
            }
        }
    
    func askQuestion() { //Needed to change the shuffle and potential answer
        countries.remove(at: correctAnswer) // will remove the country from the array
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
        questionCounter += 1
    }
    
    func restart() {
        questionCounter = 1
        score = 0
        countries = Self.allCountries
        askQuestion()  // Just passed in the function instead of retyping all of the directions
    }
    
}

#Preview {
    ContentView()
}
