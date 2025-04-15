import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // 환영 메시지와 프로필 아이콘
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("안녕하세요")
                            .font(.title2)
                        
                        Text("\(viewModel.currentUser?.nickname ?? "사용자") 님!")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.green)
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                // 로고 이미지
                Image("sprout")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .padding(.vertical, 40)
                
                // 로그아웃 버튼
                Button(action: {
                    withAnimation {
                        viewModel.logout()
                    }
                }) {
                    HStack {
                        Image(systemName: "arrow.right.square")
                        Text("로그아웃")
                    }
                    .foregroundColor(.white)
                    .frame(width: 150)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                    .shadow(radius: 3)
                }
                
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