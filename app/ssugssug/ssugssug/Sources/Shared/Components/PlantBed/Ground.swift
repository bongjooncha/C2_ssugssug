import SwiftUI

struct Ground: View {
    var color: Color
    var skew: CGFloat
    var plantType: Int?
    var plantHeight: CGFloat
    var plantWidth: CGFloat
    
    init(_ plantType: Int? = nil, _ skew: CGFloat = 60, _ color: Color = .brown, _ plantHeight: CGFloat = 50, _ plantWidth: CGFloat = 300) {
        self.plantType = plantType
        self.skew = skew
        self.color = color
        self.plantHeight = plantHeight
        self.plantWidth = plantWidth
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                Parallelogram(skew: skew)
                    .fill(color)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                if let plantType = plantType {
                    switch plantType {
                    case 0:
                        GreenOnion(plantWidth, plantHeight)
                            .offset(y: -25)
                    case 1:
                        Calabash(plantHeight)
                            .offset(y: -25)
                    case 2:
                        Bamboo(plantWidth, plantHeight)
                            .offset(y: -25)
                    default:
                        EmptyView()
                    }
                }
            }
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


#Preview {
//    Ground(1, 70, .brown, 100)
//        .frame(width: 300, height: 50)
    Ground(2, 70, .brown, 200, 25)
        .frame(width: 300, height: 50)
    
}
