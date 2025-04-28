import SwiftUI

struct GroupView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("그룹 뷰")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    GroupView()
}