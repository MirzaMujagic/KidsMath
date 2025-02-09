import SwiftUI

struct ContentView: View {
    @State private var selectedLevel: Int? = nil
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Math for Kids")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                NavigationLink(destination: GameView(level: 1), tag: 1, selection: $selectedLevel) {
                    Button("Level 1") {
                        selectedLevel = 1
                    }
                    .buttonStyle(LevelButtonStyle())
                }
                
                NavigationLink(destination: GameView(level: 2), tag: 2, selection: $selectedLevel) {
                    Button("Level 2") {
                        selectedLevel = 2
                    }
                    .buttonStyle(LevelButtonStyle())
                }
            }
        }
    }
}

struct LevelButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
