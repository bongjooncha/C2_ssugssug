import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: AuthViewModel
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            // 탭에 따른 뷰 전환
            TabView(selectedTab: selectedTab, viewModel: viewModel)
            
            // 하단 탭바는 항상 아래에 고정
            VStack {
                Spacer()
                BottomNavBar(selectedTab: $selectedTab)
            }
            .ignoresSafeArea(.keyboard)
        }
    }
}

struct TabView: View {
    let selectedTab: Int
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            switch selectedTab {
            case 0:
                HomeView(viewModel: viewModel)
            case 1:
                GroupView()
            case 2:
                SettingView()
            default:
                HomeView(viewModel: viewModel)
            }
            
            Spacer(minLength: 0)
        }
    }
}

#Preview {
    MainView(viewModel: AuthViewModel())
}