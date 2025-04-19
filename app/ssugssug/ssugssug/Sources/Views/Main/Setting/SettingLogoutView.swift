import SwiftUI

struct SettingLogoutView: View {
    @ObservedObject var viewModel: AuthViewModel
    var body: some View {
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
            .padding()
            .background(Color.red)
            .cornerRadius(10)
            .shadow(radius: 3)
        }
    }
}

