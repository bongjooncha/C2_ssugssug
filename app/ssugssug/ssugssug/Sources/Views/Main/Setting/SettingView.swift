import SwiftUI

struct SettingView: View {
    @StateObject private var viewModel = StudyViewModel()
    @State private var showDeleteConfirmation = false
    @State private var isLoading = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // 현재는 하드코딩된 사용자 이름이지만, 실제로는 로그인된 사용자 정보를 사용해야 합니다
    private let username = "Test2"
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
                    // 사용자 프로필 정보
                    HStack {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 60, height: 60)
                            .overlay(
                                Text(String(username.first ?? Character("")))
                                    .font(.title)
                                    .fontWeight(.bold)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(username)
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text("내 스터디")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.leading, 8)
                        
                        Spacer()
                    }
                    .padding(.bottom, 20)
                    
                    // 스터디 목록
                    if viewModel.studies.isEmpty && !viewModel.isLoading {
                        Text("참여 중인 스터디가 없습니다")
                            .font(.body)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 40)
                    } else {
                        List {
                            ForEach(viewModel.studies) { study in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(study.study_name)
                                        .font(.headline)
                                    
                                    HStack {
                                        Text(study.typeString)
                                            .font(.subheadline)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 2)
                                            .background(study.study_type == 0 ? Color.blue.opacity(0.2) : Color.green.opacity(0.2))
                                            .cornerRadius(4)
                                        
                                        Spacer()
                                        
                                        Text("진행: \(study.meating_goal)/\(study.meating_num)")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                    
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
            .navigationTitle("설정")
            .navigationBarItems(trailing:
                Button(action: {
                    showDeleteConfirmation = true
                }) {
                    Text("계정 삭제")
                        .foregroundColor(.red)
                }
            )
            .onAppear {
                viewModel.fetchUserStudies(username: username)
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
    SettingView()
}
