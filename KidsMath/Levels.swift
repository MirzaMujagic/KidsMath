import Foundation

struct Levels {
    func getOperations(for level: Int) -> [String] {
        switch level {
        case 1: return ["+", "-"]
        case 2: return ["+", "-"]
        default: return ["+"]
        }
    }

    func getNumberRange(for level: Int) -> ClosedRange<Int> {
        switch level {
        case 1: return 1...30
        case 2: return 30...100
        default: return 1...10
        }
    }
}
