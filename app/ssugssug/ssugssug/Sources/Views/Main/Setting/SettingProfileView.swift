import SwiftUI

struct ProfileView: View {
    let username: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("닉네임: ")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                Text(username)
                    .padding(.leading, 10)
            }
            .padding(.leading, 8)
            
            Spacer()
        }
    }
}

#Preview {
    ProfileView(username: "Test2")
} 