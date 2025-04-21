import SwiftUI

struct Bamboo: View {
    var width: CGFloat = 40
    var height: CGFloat = 200
    
    static let darkGreen = Color(red: 0/255, green: 100/255, blue: 0/255)
    
    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Self.darkGreen, location: max(0, min(1,0))),
                        .init(color: .green, location: 1)
                    ]),
                    startPoint: .bottom,
                    endPoint: .top
                )
            )
            .frame(width: width, height: height)
    }
}

struct Bamboo_Previews: PreviewProvider {
    static var previews: some View {
        Bamboo()
    }
}
