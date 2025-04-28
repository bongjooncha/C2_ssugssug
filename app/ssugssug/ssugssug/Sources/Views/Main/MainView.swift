import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: AuthViewModel
    @State var selectedBar = 0
    
    var body: some View {
        TabView(selection: $selectedBar) {
            HomeView(authViewModel: viewModel)
                .tabItem {
                    Image(systemName: "leaf")
                    Text("내 화단")
                }
                .tag(0)
            GroupView()
                .tabItem {
                    Image(systemName: "tree")
                    Text("전체 화단")
                }
                .tag(1)
            SettingView(authViewModel: viewModel)
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("설정")
                }
                .tag(2)
        }
        .accentColor(.green)
    }
}


#Preview {
    MainView(viewModel: AuthViewModel())
}
