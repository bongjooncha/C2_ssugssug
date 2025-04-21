import SwiftUI

struct Calabash: View {
    var size: CGFloat = 100
    
    // 색상 정의
    static let topColor = Color(hex: "FFA449")    // 상단 색상 (밝은 주황색)
    static let bottomColor = Color(hex: "99632C") // 하단 색상 (진한 갈색)
    
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

// Hex 코드를 Color로 변환하는 확장
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// 박과류 모양 변형 (호리병박 형태)
struct CalabashShape: View {
    var size: CGFloat = 100
    var neckRatio: CGFloat = 0.6 // 목 부분의 크기 비율 (0-1)
    
    static let topColor = Color(hex: "FFA449") 
    static let bottomColor = Color(hex: "99632C")
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = min(geometry.size.width, geometry.size.height)
                let height = width
                
                let bottomWidth = width
                let neckWidth = width * neckRatio
                let neckHeight = height * 0.3
                let bodyHeight = height - neckHeight
                
                // 아래 부분 (타원)
                path.addEllipse(in: CGRect(
                    x: (width - bottomWidth) / 2,
                    y: neckHeight,
                    width: bottomWidth,
                    height: bodyHeight
                ))
                
                // 윗부분 (목)
                path.move(to: CGPoint(x: (width - neckWidth) / 2, y: neckHeight))
                path.addLine(to: CGPoint(x: (width - neckWidth) / 2, y: 0))
                path.addLine(to: CGPoint(x: (width + neckWidth) / 2, y: 0))
                path.addLine(to: CGPoint(x: (width + neckWidth) / 2, y: neckHeight))
            }
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [Self.topColor, Self.bottomColor]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .aspectRatio(1, contentMode: .fit)
        .frame(width: size, height: size)
    }
}

struct Calabash_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 40) {
            Calabash()
                .frame(width: 100, height: 100)
        }
        .padding()
    }
}
