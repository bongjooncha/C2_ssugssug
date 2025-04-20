import SwiftUI

struct HomeView: View {
    @ObservedObject var AuthViewModel: AuthViewModel
    @StateObject private var studyViewModel = StudyViewModel()
    @State private var showCreateStudy = false

    
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
            .navigationBarItems(trailing: 
                Button(action: {
                    showCreateStudy = true
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("스터디 추가하기")
                    }
                    .foregroundColor(.green)
                }
            )
            .sheet(isPresented: $showCreateStudy) {
                NavigationView {
                    CreateStudyView()
                        .navigationBarItems(leading: 
                            Button(action: {
                                showCreateStudy = false
                            }) {
                                Image(systemName: "chevron.left")
                            }
                        )
                }
            }
        }
    }
} 

#Preview {
    HomeView(AuthViewModel: AuthViewModel())
}
