import SwiftUI
import Firebase

@main
struct KidsMathApp: App {
    @StateObject private var gameCenterManager = GameCenterManager()
    //@StateObject private var navigationManager = NavigationManager()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameCenterManager)
                //.environmentObject(navigationManager)
        }
    }
}
