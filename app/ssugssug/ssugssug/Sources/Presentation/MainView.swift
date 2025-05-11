import SwiftUI

struct MainView: View {
    @State var selectedBar = 0
    
    var body: some View {
        TabView(selection: $selectedBar) {
            HomeView()
                .tabItem {
                    Image(systemName: "leaf")
                    Text("내 화단")
                }
                .tag(0)
            SettingView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("설정")
                }
                .tag(1)
        }
        .accentColor(.green)
    }
}


#Preview {
    MainView()
}
