import SwiftUI

struct SettingView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @StateObject private var viewModel = StudyViewModel()
    @State private var showDeleteConfirmation = false
    @State private var isLoading = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    private var username: String? {
        return authViewModel.currentUser?.nickname
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Spacer()
                VStack(alignment: .leading) {
                    SettingLogoutView(viewModel: authViewModel)
                    // 사용자 프로필 정보
                    ProfileView(username: username ?? "")
                        .padding(.bottom, 40)
                        .padding(.top, 20)

                    
                    // 스터디 목록
                    StudyListView(viewModel: viewModel)
                        .padding(.leading, 8)
                    
                    Spacer()
                }
                .padding()
                
                // 로딩 인디케이터
                if viewModel.isLoading || isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.1))
                }
            }
            .navigationTitle("내 정보")
            .navigationBarItems(trailing:
                Button(action: {
                    showDeleteConfirmation = true
                }) {
                    Text("계정 삭제")
                        .foregroundColor(.red)
                }
            )
            .onAppear {
                viewModel.fetchUserStudies(username: username ?? "")
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("알림"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("확인"))
                )
            }
            .actionSheet(isPresented: $showDeleteConfirmation) {
                ActionSheet(
                    title: Text("계정 삭제"),
                    message: Text("정말로 계정을 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다."),
                    buttons: [
                        .destructive(Text("삭제")) {
                            deleteAccount()
                        },
                        .cancel(Text("취소"))
                    ]
                )
            }
        }
    }
    
    private func deleteAccount() {
        isLoading = true
        
        viewModel.deleteAccount { success in
            isLoading = false
            
            if success {
                alertMessage = "계정이 성공적으로 삭제되었습니다."
                // 여기서 로그아웃 로직 처리
            } else {
                alertMessage = "계정 삭제에 실패했습니다. 다시 시도해 주세요."
            }
            
            showAlert = true
        }
    }
}

#Preview {
    SettingView(authViewModel: AuthViewModel())
}
