import SwiftUI

struct RewardView: View {
    var body: some View {
        VStack {
            Text("🎉 Congratulations! 🎉")
                .font(.largeTitle)
                .bold()
            Text("You answered 10 questions!")
                .font(.title2)
        }
        .padding()
    }
}
