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
                VStack(spacing: 15) {
                    Text("쑥쑥")
                        .font(.system(size: 36, weight: .bold))
                    Text("🌱")
                        .font(.system(size: 40))
                }
                .padding(.top, 20)
                
                // 회원가입 폼
                VStack(spacing: 20) {
                    Text("Create an account")
                        .font(.headline)
                    
                    VStack(spacing: 5) {
                        Text("Enter your id")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 25)
                        
                        TextFieldWithIcon(
                            icon: "person",
                            placeholder: "nickname",
                            text: $nickname
                        )
                    }
                    
                    VStack(spacing: 5) {
                        Text("Enter pwd")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 25)
                        
                        TextFieldWithIcon(
                            icon: "lock",
                            placeholder: "pwd",
                            text: $password,
                            isSecure: true
                        )
                        
                        TextFieldWithIcon(
                            icon: "lock.shield",
                            placeholder: "check your pwd",
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
    
}
