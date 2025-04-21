import SwiftUI

struct Ground: View {
    var color: Color = .brown
    var skew: CGFloat = 60 // 평행사변형의 기울기 각도
    
    var body: some View {
        GeometryReader { geometry in
            Parallelogram(skew: skew)
                .fill(color)
                .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

// 평행사변형 모양을 정의하는 Shape
struct Parallelogram: Shape {
    var skew: CGFloat // 평행사변형의 기울기 각도(도)
    
    func path(in rect: CGRect) -> Path {
        let skewAmount = rect.height * tan(skew * .pi / 180)
        
        var path = Path()
        path.move(to: CGPoint(x: skewAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - skewAmount, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        path.closeSubpath()
        
        return path
    }
}

struct Ground_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            Ground()
                .frame(width: 300, height: 50)
        }
        .padding()
    }
}
