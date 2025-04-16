import SwiftUI

struct UserHeaderView: View {
    let nickname: String?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("안녕하세요")
                    .font(.title2)
                
                Text("\(nickname ?? "사용자") 님!")
                    .font(.title)
                    .fontWeight(.bold)
            }
            
            Spacer()
            
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.green)
        }
        .padding(.horizontal)
        .padding(.top, 20)
    }
}

#Preview {
    UserHeaderView(nickname: "테스트")
} 