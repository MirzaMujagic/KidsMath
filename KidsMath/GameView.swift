import SwiftUI

struct GameView: View {
    let level: Int
    @State private var questions: [(Int, Int, String, String, Bool)] = []
    @State private var startTime = Date()
    @State private var showResults = false
    @Environment(\.presentationMode) var presentationMode
    @FocusState private var focusedQuestion: Int?

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
                    ForEach(0..<questions.count, id: \..self) { index in
                        HStack {
                            Text("\(questions[index].0) \(questions[index].2) \(questions[index].1) =")
                            
                            TextField("?", text: $questions[index].3)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 50)
                                .keyboardType(.numberPad) // ✅ Forces number-only keyboard
                                .focused($focusedQuestion, equals: index) // ✅ Forces focus
                                .disabled(questions[index].4)
                                .foregroundColor(questions[index].4 && questions[index].3 != "\(GameManager.correctAnswer(for: questions[index]))" ? .red : .black)
                                .onChange(of: focusedQuestion) { newFocus in
                                    if let previousIndex = newFocus, previousIndex > 0 {
                                        checkAnswer(index: previousIndex - 1)
                                    }
                                }
                        }
                    }
                }
            }

            Button("Finish") {
                showResults = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .disabled(questions.contains { $0.3.isEmpty })
        }
        .padding()
        .onAppear {
            startTime = Date()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                focusedQuestion = 0  // Automatically focuses on first input field
            }
        }
        .fullScreenCover(isPresented: $showResults) {
            ResultView(questions: questions, startTime: startTime)
        }
    }

    func checkAnswer(index: Int) {
        if let userAnswer = Int(questions[index].3) {
            if userAnswer != GameManager.correctAnswer(for: questions[index]) {
                questions[index].4 = true
            }
        }
    }
}

