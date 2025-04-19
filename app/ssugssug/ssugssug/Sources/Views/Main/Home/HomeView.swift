import SwiftUI

struct HomeView: View {
    @ObservedObject var AuthViewModel: AuthViewModel
    @StateObject private var studyViewModel = StudyViewModel()

    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // 환영 메시지와 프로필 아이콘
                UserHeaderView(nickname: AuthViewModel.currentUser?.nickname)

                Spacer()
                HomeMainView(studyViewModel: studyViewModel)
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
        }
    }
} 

#Preview {
    HomeView(AuthViewModel: AuthViewModel())
}
