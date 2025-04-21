
import SwiftUI

struct GreenOnion: View {
    var width: CGFloat
    var height: CGFloat

    init(_ width: CGFloat = 40, _ height: CGFloat = 200) {
        self.width = width
        self.height = height
    }
    
    static let darkGreen = Color(red: 0/255, green: 150/255, blue: 0/255)
    
    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: .white, location: max(0, min(1,0))),
                        .init(color: Self.darkGreen, location: 0.5)
                    ]),
                    startPoint: .bottom,
                    endPoint: .top
                )
            )
            .frame(width: width, height: height)
    }
}

#Preview {
    GreenOnion(50, 300)
}
