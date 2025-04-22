import SwiftUI

struct UserHeaderView: View {
    @Binding var showCreateStudy: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("내 화단")
                    .font(.title)
                    .fontWeight(.bold)

                Button(action: {
                    showCreateStudy = true
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("스터디 추가하기")
                    }
                    .padding(.vertical, 8)
                    .foregroundColor(.green)
                    .cornerRadius(10)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(.horizontal)
        .padding(.top, 20)
    }
}

#Preview {
    UserHeaderView(showCreateStudy: .constant(false))
} 