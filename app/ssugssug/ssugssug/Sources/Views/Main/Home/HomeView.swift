import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // 환영 메시지와 프로필 아이콘
                UserHeaderView(nickname: viewModel.currentUser?.nickname)

                // MainView
                HomeMainView(viewModel: viewModel)

                
                // // 로그아웃 버튼
                // Button(action: {
                //     withAnimation {
                //         viewModel.logout()
                //     }
                // }) {
                //     HStack {
                //         Image(systemName: "arrow.right.square")
                //         Text("로그아웃")
                //     }
                //     .foregroundColor(.white)
                //     .frame(width: 150)
                //     .padding()
                //     .background(Color.red)
                //     .cornerRadius(10)
                //     .shadow(radius: 3)
                // }
                
                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
        }
    }
} 

#Preview {
    HomeView(viewModel: AuthViewModel())
}