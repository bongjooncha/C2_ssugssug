import SwiftUI

struct InfoCard: View {
    let title: String
    let value: String
    let backgroundColor: Color
    let borderColor: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.footnote)
                .foregroundColor(.gray)
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 15)
        .background(backgroundColor)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(borderColor, lineWidth: 1)
        )
    }
}


#Preview {
    InfoCard(title: "만남 횟수", value: "4/10", backgroundColor: .white, borderColor: Color.gray.opacity(0.2))
}
