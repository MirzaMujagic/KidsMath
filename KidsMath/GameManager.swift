import Foundation

class GameManager: ObservableObject {
    @Published var number1 = 0
    @Published var number2 = 0
    @Published var operation = ""
    @Published var score = 0
    @Published var questionCount = 0
    @Published var showReward = false

    let levels = Levels()

    func generateNewQuestion(for level: Int) {
        let operations = levels.getOperations(for: level)
        operation = operations.randomElement() ?? "+"

        let range = levels.getNumberRange(for: level)
        number1 = Int.random(in: range)
        number2 = Int.random(in: range)

        if operation == "-" && number1 < number2 {
            swap(&number1, &number2) // Ensure no negative results
        }
    }

    func correctAnswer() -> Int {
        switch operation {
        case "+": return number1 + number2
        case "-": return number1 - number2
        default: return 0
        }
    }

    func checkAnswer(_ answer: Int) {
        if answer == correctAnswer() {
            score += 1
        }
        questionCount += 1

        if questionCount == 10 {
            showReward = true
            questionCount = 0
            score = 0
        }
    }
}
