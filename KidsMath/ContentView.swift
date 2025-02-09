import SwiftUI

struct ContentView: View {
    @State private var selectedLevel: Int? = nil
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Math for Kids")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                NavigationLink(destination: GameView(level: 1)) {
                    Text("Level 1")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: GameView(level: 2)) {
                    Text("Level 2")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
