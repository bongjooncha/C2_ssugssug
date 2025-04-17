import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                UserHeaderView(nickname: viewModel.currentUser?.nickname)
                HomeMainView(viewModel: viewModel)
                
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