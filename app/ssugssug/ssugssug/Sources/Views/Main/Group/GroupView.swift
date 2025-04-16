import SwiftUI

struct GroupView: View {
    var body: some View {
        VStack {
            Text("그룹 뷰")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    GroupView()
}