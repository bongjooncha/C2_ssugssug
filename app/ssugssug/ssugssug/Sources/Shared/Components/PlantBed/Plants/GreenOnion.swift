
import SwiftUI

struct GreenOnion: View {
    var width: CGFloat = 40
    var height: CGFloat = 200
    
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
    GreenOnion()
}
