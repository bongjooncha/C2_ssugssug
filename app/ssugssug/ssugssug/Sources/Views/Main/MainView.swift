import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: AuthViewModel
    @StateObject private var navState = NavigationState()
    
    var body: some View {
        ZStack {
            TabView(viewModel: viewModel)
                .environmentObject(navState) 
            
            if navState.showTabBar {
                VStack {
                    Spacer()
                    BottomNavBar(selectedTab: $navState.selectedTab)
                }
                .ignoresSafeArea(.keyboard)
            }
        }
        .environmentObject(navState)
    }
}

struct TabView: View {
    @EnvironmentObject var navState: NavigationState
    @ObservedObject var viewModel: AuthViewModel
 
    var body: some View {
        VStack {
            switch navState.selectedTab {
            case 0:
                HomeView(authViewModel: viewModel)
            case 1:
                GroupView()
            case 2:
                SettingView(authViewModel: viewModel)
            default:
                HomeView(authViewModel: viewModel)
            }
            
            Spacer(minLength: 0)
        }
    }
}

#Preview {
    MainView(viewModel: AuthViewModel())
        .environmentObject(NavigationState())
}
