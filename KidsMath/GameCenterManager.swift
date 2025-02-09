import Foundation
import GameKit

class GameCenterManager: NSObject, ObservableObject {
    @Published var playerName: String = "Guest"
    @Published var playerID: String = ""
    @Published var isAuthenticated = false

    override init() {
        super.init()
        authenticateUser()
    }

    func authenticateUser() {
        let localPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = { vc, error in
            if let vc = vc {
                // Show Game Center login UI
                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = scene.windows.first,
                   let rootVC = window.rootViewController {
                    rootVC.present(vc, animated: true, completion: nil)
                }
            } else if localPlayer.isAuthenticated {
                self.isAuthenticated = true
                self.playerName = localPlayer.displayName
                self.playerID = localPlayer.teamPlayerID // Unique per game
                print("Game Center authenticated: \(self.playerName) (\(self.playerID))")
            } else {
                print("Game Center authentication failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
}
