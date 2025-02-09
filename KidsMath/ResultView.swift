import SwiftUI
import FirebaseFirestore
import GameKit

struct ResultView: View {
    let questions: [(Int, Int, String, String, Bool)]
    let startTime: Date
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var gameCenterManager: GameCenterManager

    var incorrectCount: Int {
        questions.filter { $0.4 }.count
    }

    var totalTime: Double {
        Date().timeIntervalSince(startTime)
    }

    var score: Int {
        let correctAnswers = questions.count - incorrectCount
        return correctAnswers * 10 - Int(totalTime)
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Results")
                .font(.largeTitle)
                .bold()
                .padding()

            Text("Player: \(gameCenterManager.playerName)")
                .font(.title2)

            Text("Your Score: \(score)")
                .font(.title)
                .bold()

            Button("Save Score to Leaderboard") {
                saveScoreToFirebase()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)

            Button("Back to Main Menu") {
                goToMainMenu()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }

    func saveScoreToFirebase() {
        guard !gameCenterManager.playerID.isEmpty else { return }

        let db = Firestore.firestore()
        db.collection("leaderboard").document(gameCenterManager.playerID).setData([
            "playerID": gameCenterManager.playerID,
            "playerName": gameCenterManager.playerName,
            "score": score,
            "time": totalTime,
            "date": Timestamp(date: Date())
        ]) { error in
            if let error = error {
                print("Error saving score: \(error.localizedDescription)")
            } else {
                print("Score saved successfully!")
            }
        }
    }

    func goToMainMenu() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = UIHostingController(rootView: ContentView().environmentObject(gameCenterManager))
            window.makeKeyAndVisible()
        }
    }
}
