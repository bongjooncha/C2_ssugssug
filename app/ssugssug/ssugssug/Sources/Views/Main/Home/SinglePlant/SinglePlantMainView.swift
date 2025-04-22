import SwiftUI

struct SinglePlantMainView: View {
    let study: Study
    @Environment(\.presentationMode) var presentationMode
    @State private var showMemoView = false
    @State private var showStartStudyView = false
    @State private var showLoadingPage = false 
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 15) {
                // 메모 보기 버튼
                NavigationLink(destination: MemoView(study: study)) {
                    ActionButton(
                        title: "메모 보기",
                        backgroundColor: Color.green.opacity(0.2),
                        foregroundColor: .green
                    )
                }
                
                // 스터디 시작 버튼 (아직 구현하지 않음 - 주석 처리)
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
            
            
            Ground(2, 70, .brown, 200, 25)
                .frame(width: 300, height: 50)
                .padding(.vertical, 220)
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
    }
}   

#Preview {
    SinglePlantMainView(study: Study(
        nickname: "사용자", 
        study_name: "알고리즘 스터디", 
        study_type: 0, 
        meating_num: 4,
        meating_goal: 10 
    ))
}
