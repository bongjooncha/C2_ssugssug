import SwiftUI

// 액션 버튼 컴포넌트
struct ActionButton: View {
    let title: String
    let backgroundColor: Color
    let foregroundColor: Color
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(foregroundColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(backgroundColor)
            .cornerRadius(10)
    }
}

#Preview {
    ActionButton(title: "메모 보기", backgroundColor: .green, foregroundColor: .white)
}
