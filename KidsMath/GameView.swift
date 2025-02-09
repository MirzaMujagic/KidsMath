import SwiftUI

struct GameView: View {
    let level: Int
    @State private var questions: [(Int, Int, String, String, Bool)] = []
    @Environment(\.presentationMode) var presentationMode
    
    init(level: Int) {
        self.level = level
        _questions = State(initialValue: GameManager.generateQuestions(for: level))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Level \(level)")
                .font(.largeTitle)
                .bold()
                .padding()
            
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(0..<questions.count, id: \.self) { index in
                        HStack {
                            Text("\(questions[index].0) \(questions[index].2) \(questions[index].1) =")
                            TextField("?", text: $questions[index].3, onCommit: {
                                checkAnswer(index: index)
                            })
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 50)
                            .disabled(questions[index].4)
                            .foregroundColor(questions[index].4 && questions[index].3 != "\(GameManager.correctAnswer(for: questions[index]))" ? .red : .black)
                        }
                    }
                }
            }
            
            Button("Back") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
    
    func checkAnswer(index: Int) {
        if let userAnswer = Int(questions[index].3) {
            if userAnswer != GameManager.correctAnswer(for: questions[index]) {
                questions[index].4 = true
            }
        }
    }
}