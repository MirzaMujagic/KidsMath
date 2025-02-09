import SwiftUI

struct ContentView: View {
    @StateObject private var gameManager = GameManager()
    @State private var selectedLevel = 1
    @State private var answer = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Math for Kids")
                .font(.largeTitle)
                .bold()
                .padding()

            Picker("Select Level", selection: $selectedLevel) {
                Text("Level 1").tag(1)
                Text("Level 2").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onChange(of: selectedLevel) {
                gameManager.generateNewQuestion(for: selectedLevel)
            }

            Text("\(gameManager.number1) \(gameManager.operation) \(gameManager.number2) = ?")
                .font(.title)
                .padding()

            TextField("Your answer", text: $answer)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .padding()

            Button("Submit") {
                if let userAnswer = Int(answer) {
                    gameManager.checkAnswer(userAnswer)
                }
                answer = ""
                gameManager.generateNewQuestion(for: selectedLevel)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            Text("Score: \(gameManager.score)")
                .font(.headline)
                .padding()

            if gameManager.showReward {
                RewardView()
            }
        }
        .padding()
        .onAppear { gameManager.generateNewQuestion(for: selectedLevel) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
