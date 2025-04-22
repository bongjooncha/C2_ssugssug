import SwiftUI

struct HomeView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var studyViewModel: StudyViewModel
    @Binding var navBarHidden: Bool
    @State private var showCreateStudy = false

    private var username: String? {
        return authViewModel.currentUser?.nickname
    }
    
    init(authViewModel: AuthViewModel, studyViewModel: StudyViewModel = StudyViewModel(), navBarHidden: Binding<Bool>) {
        self.authViewModel = authViewModel
        self.studyViewModel = studyViewModel
        self._navBarHidden = navBarHidden
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                UserHeaderView(showCreateStudy: $showCreateStudy)
                HomeMainView(studyViewModel: studyViewModel, navBarHidden: $navBarHidden)
                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if studyViewModel.username.isEmpty {
                    studyViewModel.fetchUserStudies(username: username ?? "")
                }
            }
            .sheet(isPresented: $showCreateStudy) {
                NavigationView {
                    CreateStudyView(user: authViewModel.currentUser)
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
    HomeView(
        authViewModel: AuthViewModel(),
        studyViewModel: StudyViewModel(username: "Test2"),
        navBarHidden: .constant(false)
    )
}
