import SwiftUI

struct ResultView: View {
    let questions: [(Int, Int, String, String, Bool)]
    let startTime: Date
    @Environment(\.presentationMode) var presentationMode
    
    var incorrectCount: Int {
        questions.filter { $0.4 }.count
    }
    
    var totalTime: String {
        let timeInterval = Date().timeIntervalSince(startTime)
        return String(format: "%.2f seconds", timeInterval)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Results")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Text("Incorrect Answers: \(incorrectCount)")
                    .font(.title)
                
                Text("Time Taken: \(totalTime)")
                    .font(.title)
                
                if incorrectCount == 0 {
                    VStack {
                        Text("🎖 Gold Medal! 🎖")
                            .font(.largeTitle)
                            .bold()
                        Text("Perfect Score!")
                            .font(.title)
                        Image(systemName: "medal")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .foregroundColor(.yellow)
                    }
                    .padding()
                    .transition(.scale)
                }
                
                NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true)) {
                    Text("Back to Main Menu")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}
//
//  ResultView.swift
//  KidsMath
//
//  Created by Mirza Mujagic on 2025-02-09.
//

