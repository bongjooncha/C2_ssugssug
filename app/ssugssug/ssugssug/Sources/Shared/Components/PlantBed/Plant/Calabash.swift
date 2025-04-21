import SwiftUI

struct Calabash: View {
    var size: CGFloat

    // 간결한 초기화 메서드
    init(_ size: CGFloat = 50) {
        self.size = size
    }
    
    // 색상 정의 - hex 문자열 대신 직접 Color 값 사용
    static let topColor = Color(red: 255/255, green: 164/255, blue: 73/255)
    static let bottomColor = Color(red: 153/255, green: 99/255, blue: 44/255)
    
    var body: some View {
        Circle()
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [Self.topColor, Self.bottomColor]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(width: size, height: size)
    }
}

#Preview {
    Calabash(200)
}
