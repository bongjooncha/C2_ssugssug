import SwiftUI


class NavigationState: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var showTabBar: Bool = true
}

/*
 
 @StateObject -> 주인(초기화. 시점)
 
 @ObservedObject -> 노예(초기화 시점)
 
 @EnvrionmentObject -> 의존성 주입
 
 
 */
