import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: AuthViewModel
    @State private var selectedTab = 0
    @State private var navBarHidden = false
    
    var body: some View {
        ZStack {
            // 탭에 따른 뷰 전환
            TabView(selectedTab: selectedTab, viewModel: viewModel, navBarHidden: $navBarHidden)
            
            // 하단 탭바는 항상 아래에 고정
            if !navBarHidden {
                VStack {
                    Spacer()
                    BottomNavBar(selectedTab: $selectedTab)
                }
                .ignoresSafeArea(.keyboard)
            }
        }
    }
}

struct TabView: View {
    let selectedTab: Int
    @ObservedObject var viewModel: AuthViewModel
    @Binding var navBarHidden: Bool
 
    var body: some View {
        VStack {
            switch selectedTab {
            case 0:
                HomeView(authViewModel: viewModel, navBarHidden: $navBarHidden)
            case 1:
                GroupView()
            case 2:
                SettingView(authViewModel: viewModel)
            default:
                HomeView(authViewModel: viewModel, navBarHidden: $navBarHidden)
            }
            
            Spacer(minLength: 0)
        }
    }
}

#Preview {
    MainView(viewModel: AuthViewModel())
}
