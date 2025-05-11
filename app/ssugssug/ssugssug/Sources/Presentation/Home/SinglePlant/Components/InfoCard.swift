import SwiftUI

struct InfoCard: View {
    let title: String
    let percent: String
    let amount: String
    let backgroundColor: Color
    let borderColor: Color
    
    var body: some View {
        HStack(alignment: .center) {
            Text(title)
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.trailing, 10)
            
            HStack(alignment: .lastTextBaseline) {
                Text(percent)
                    .font(.title3)
                    .fontWeight(.bold)

                Text(amount)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 16)
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
    InfoCard(title: "만남 횟수", percent: "25%", amount: "4/10", backgroundColor: .white, borderColor: Color.gray.opacity(0.2))
}
