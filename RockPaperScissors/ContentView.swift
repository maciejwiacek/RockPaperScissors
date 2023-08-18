//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Maciej Wiącek on 19/08/2023.
//

import SwiftUI

struct UserIcon: View {
    var icon: String
    
    var body: some View {
        Text(icon)
            .font(.system(size: 75))
    }
}

struct ContentView: View {
    @State private var currentAppChoice = Int.random(in: 0...2)
    @State private var shouldPlayerWin = Bool.random()
    @State private var playerChoice = ""
    
    @State private var showingRoundAlert = false
    @State private var showingGameAlert = false
    @State private var roundAlertTitle = ""
    @State private var roundAlertMessage = ""
    @State private var gameAlertMessage = ""
    
    @State private var currentRound = 0
    @State private var totalRounds = 10
    @State private var playerScore = 0
    
    let possibleChoices = ["👊", "✋", "✌️"]
    
    var didPlayerWin: Bool {
        switch(currentAppChoice, playerChoice) {
        case(0, "👊"):
            return false
        case(0, "✋"):
            return true
        case(0, "✌️"):
            return false
        case(1, "👊"):
            return false
        case(1, "✋"):
            return false
        case(1, "✌️"):
            return true
        case(2, "👊"):
            return true
        case(2, "✋"):
            return false
        case(2, "✌️"):
            return false
        default:
            return false
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Text("You should:")
                    .font(.title.weight(.semibold))
                
                Text(shouldPlayerWin ? "WIN" : "LOSE")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(shouldPlayerWin ? .green : .red)
            }
            Spacer()
            Spacer()
            VStack {
                Text("Computer chose")
                    .font(.title2.bold())
                Text(possibleChoices[currentAppChoice])
                    .font(.system(size: 100))
            }
            Spacer()
            Spacer()
            VStack(spacing: 30) {
                Text("Select your pick")
                    .font(.title2.weight(.semibold))
                HStack(spacing: 30) {
                    ForEach(possibleChoices, id: \.self) { choice in
                        Button {
                            playerChoice = choice
                            onClick()
                        } label: {
                            UserIcon(icon: choice)
                        }
                    }
                }
            }
            Spacer()
        }
        .alert(roundAlertTitle, isPresented: $showingRoundAlert) {
            Button("Continue", action: nextRound)
        } message: {
            Text(roundAlertMessage)
        }
        .alert("Congrats!", isPresented: $showingGameAlert) {
            Button("Restart", action: nextRound)
        } message: {
            Text(gameAlertMessage)
        }
    }
    
    func onClick() {
        if didPlayerWin == shouldPlayerWin {
            playerScore += 1
            roundAlertTitle = "Correct!"
            roundAlertMessage = "You were right! +1 point"
        } else {
            roundAlertTitle = "Wrong!"
            roundAlertMessage = "You were wrong :("
        }
        
        currentRound += 1
        showingRoundAlert = true
    }
    
    func nextRound() {
        if currentRound == totalRounds {
            showingRoundAlert = false
            showingGameAlert = true
            gameAlertMessage = "It was final round. Your score is \(playerScore)/\(totalRounds)"
            playerScore = 0
            currentRound = 0
        }
        
        currentAppChoice = Int.random(in: 0...2)
        shouldPlayerWin.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
