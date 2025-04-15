import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel: AuthViewModel
    @State private var nickname: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                // 로고 영역
                Image("Title")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.5) 
                    .padding(.top, 100)
                    .padding(.bottom, 50)
                
                // 회원가입 폼
                VStack(spacing: 20) {
                    Text("계정 생성하쓀~?")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                
                    
                    VStack(spacing: 5) {
                        NickNameField(nickname: $nickname)
                    }
                    
                    Text("비밀번호는 필쑤~")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                

                    VStack(spacing: 5) {

                        TextFieldWithIcon(
                            icon: "lock",
                            placeholder: "!!!비밀번호!!!",
                            text: $password,
                            isSecure: true
                        )
                        
                        TextFieldWithIcon(
                            icon: "lock.shield",
                            placeholder: "비밀번호 확인~",
                            text: $confirmPassword,
                            isSecure: true
                        )
                    }
                    
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
                        viewModel.register(nickname: nickname, password: password, confirmPassword: confirmPassword)
                        if viewModel.isAuthenticated {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .padding(.top, 10)
                }
                .padding(.horizontal)
                
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .padding()
                }
                
                Spacer()
            }
            .navigationBarItems(leading: Button("취소") {
                presentationMode.wrappedValue.dismiss()
            })
            .background(Color(UIColor.systemBackground))
            .animation(.easeInOut, value: viewModel.errorMessage)
            .animation(.easeInOut, value: viewModel.isLoading)
        }
    }
} 

#Preview {
    RegisterView(viewModel: AuthViewModel())
}
