import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: AuthViewModel
    @State private var nickname: String = ""
    @State private var password: String = ""
    @State private var showRegister = false
    
    var body: some View {
        VStack(spacing: 30) {
            // 로고 영역
            VStack(spacing: 15) {
                Text("쑥쑥")
                    .font(.system(size: 36, weight: .bold))
                Text("🌱")
                    .font(.system(size: 40))
            }
            .padding(.top, 50)
            
            // 로그인 폼
            VStack(spacing: 20) {
                Text("Login")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                TextFieldWithIcon(
                    icon: "person",
                    placeholder: "nickname",
                    text: $nickname
                )
                
                TextFieldWithIcon(
                    icon: "lock",
                    placeholder: "pwd",
                    text: $password,
                    isSecure: true
                )
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .transition(.opacity)
                }
                
                PrimaryButton(
                    title: "Continue",
                    isDisabled: viewModel.isLoading
                ) {
                    viewModel.login(nickname: nickname, password: password)
                }
                .padding(.top, 10)
            }
            .padding(.top, 20)
            
            // 회원가입 버튼
            Button("계정 만들기") {
                showRegister = true
            }
            .padding(.top, 15)
            
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(1.5)
                    .padding()
            }
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .sheet(isPresented: $showRegister) {
            RegisterView(viewModel: viewModel)
        }
        .animation(.easeInOut, value: viewModel.errorMessage)
        .animation(.easeInOut, value: viewModel.isLoading)
    }
}


