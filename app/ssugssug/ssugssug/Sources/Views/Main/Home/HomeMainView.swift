import SwiftUI

struct HomeMainView: View {
    @ObservedObject var viewModel: AuthViewModel
    var body: some View {
                        // 로고 이미지
        Image("sprout")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 120, height: 120)
            .padding(.vertical, 40)

        // 로그아웃 버튼
        Button(action: {
            withAnimation {
                viewModel.logout()
            }
        }) {
            HStack {
                Image(systemName: "arrow.right.square")
                Text("로그아웃")
            }
            .foregroundColor(.white)
            .frame(width: 150)
            .padding()
            .background(Color.red)
            .cornerRadius(10)
            .shadow(radius: 3)
        }
    }
}

