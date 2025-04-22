import SwiftUI

struct SinglePlantMainView: View {
    let study: Study
    @Environment(\.presentationMode) var presentationMode
    @State private var showMemoView = false
    @State private var showStartStudyView = false
    @State private var showLoadingPage = false
    @EnvironmentObject var navState: NavigationState
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 15) {
                NavigationLink(destination: MemoView(study: study)) {
                    ActionButton(
                        title: "메모 보기",
                        backgroundColor: Color.green.opacity(0.2),
                        foregroundColor: .green
                    )
                }

                ActionButton(
                    title: "스터디 시작",
                    backgroundColor: Color.green.opacity(0.2),
                    foregroundColor: .green
                )
                .onTapGesture {
                    showLoadingPage = true 
                }
            }
            .padding(.horizontal)
            
            
            Ground(2, 60, .brown, 200, 25)
                .frame(width: 300, height: 50)
                .padding(.top, 150)
        }
        .padding(.vertical)
        .background(
            NavigationLink(
                destination: LoadingPageView(),
                isActive: $showLoadingPage
            ) {
                EmptyView()
            }
        )
        .onAppear {
            navState.showTabBar = true
        }
    }
}   

#Preview {
    SinglePlantMainView(study: Study(
        nickname: "사용자", 
        study_name: "알고리즘 스터디", 
        study_type: 0, 
        meating_num: 4,
        meating_goal: 10 )
    )
}
