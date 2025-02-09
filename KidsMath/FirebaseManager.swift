import Foundation
import FirebaseFirestore

class FirebaseManager {
    static let shared = FirebaseManager()
    private let db = Firestore.firestore()

    func saveScore(playerID: String, playerName: String, score: Int, completion: @escaping (Bool) -> Void) {
        let data: [String: Any] = [
            "playerID": playerID,
            "playerName": playerName,
            "score": score,
            "date": Timestamp(date: Date())
        ]
        
        db.collection("leaderboard").document(playerID).setData(data) { error in
            if let error = error {
                print("Error saving score: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Score saved successfully!")
                completion(true)
            }
        }
    }

    func fetchLeaderboard(completion: @escaping ([LeaderboardEntry]) -> Void) {
        db.collection("leaderboard")
            .order(by: "score", descending: true)
            .limit(to: 10)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching leaderboard: \(error.localizedDescription)")
                    completion([])
                } else {
                    let scores = snapshot?.documents.compactMap { doc -> LeaderboardEntry? in
                        let data = doc.data()
                        guard let playerName = data["playerName"] as? String,
                              let score = data["score"] as? Int,
                              let date = (data["date"] as? Timestamp)?.dateValue() else { return nil }
                        return LeaderboardEntry(playerName: playerName, score: score, date: date)
                    } ?? []
                    completion(scores)
                }
            }
    }
}

struct LeaderboardEntry: Identifiable {
    var id = UUID()
    var playerName: String
    var score: Int
    var date: Date
}
