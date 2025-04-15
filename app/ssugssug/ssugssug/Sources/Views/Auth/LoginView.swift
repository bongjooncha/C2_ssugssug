import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: AuthViewModel
    @State private var nickname: String = ""
    @State private var password: String = ""
    @State private var showRegister = false
    
    var body: some View {
        VStack(spacing: 30) {
            Image("Title")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.5)
                .padding(.top, 100)
                .padding(.bottom, 40)
            
            // 로그인 폼
            VStack(spacing: 20) {
                Text("로그인")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
                

                NickNameField(nickname: $nickname)
                TextFieldWithIcon(
                    icon: "lock",
                    placeholder: "비밀번호",
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
                    title: "로그인",
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
#Preview {
    LoginView(viewModel: AuthViewModel())
}
