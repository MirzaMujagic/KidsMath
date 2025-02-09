import Foundation

struct GameManager {
    static func generateQuestions(for level: Int) -> [(Int, Int, String, String, Bool)] {
        var generatedQuestions: [(Int, Int, String, String, Bool)] = []
        let operations = ["+", "-"]
        let range = level == 1 ? 1...30 : 30...100
        
        for _ in 1...10 {
            let num1 = Int.random(in: range)
            let num2 = Int.random(in: range)
            let operation = operations.randomElement()!
            
            var adjustedNum1 = num1
            var adjustedNum2 = num2
            
            if operation == "-" && num1 < num2 {
                swap(&adjustedNum1, &adjustedNum2)
            }
            
            generatedQuestions.append((adjustedNum1, adjustedNum2, operation, "", false))
        }
        return generatedQuestions
    }
    
    static func correctAnswer(for question: (Int, Int, String, String, Bool)) -> Int {
        switch question.2 {
        case "+": return question.0 + question.1
        case "-": return question.0 - question.1
        default: return 0
        }
    }
}
