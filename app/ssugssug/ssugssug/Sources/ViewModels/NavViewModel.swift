import SwiftUI

class NavigationState: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var showTabBar: Bool = true
}