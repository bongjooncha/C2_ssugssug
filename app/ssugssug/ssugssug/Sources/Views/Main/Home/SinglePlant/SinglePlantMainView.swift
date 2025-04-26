import SwiftUI

struct SinglePlantMainView: View {
    let study: Study
    @Environment(\.presentationMode) var presentationMode
    @State private var showMemoView = false
    @State private var showStartStudyView = false
    @State private var showLoadingPage = false
    @State private var showAfterTodayView = false
    @EnvironmentObject var navState: NavigationState
    @StateObject private var saveStudyVM = SaveStudyViewModel()
    
    var body: some View {
        VStack {
            VStack(spacing: 15) {
                Ground(2, 60, .brown, 200, 35)
                    .frame(width: 300, height: 50)
                    .padding(.vertical, 150)
                    .padding(.bottom, 80)
            }
            VStack(spacing: 15) {
                // 상태에 따라 버튼 변경
                if saveStudyVM.studyState == .notStarted {
                    // 스터디 시작 버튼
                    ActionButton(
                        title: "스터디 시작",
                        backgroundColor: Color.green.opacity(0.2),
                        foregroundColor: .green
                    )
                    .onTapGesture {
                        showLoadingPage = true
                    }
                } else if saveStudyVM.studyState == .finishing {
                    // 스터디 종료 버튼
                    ActionButton(
                        title: "스터디 종료",
                        backgroundColor: Color.red.opacity(0.2),
                        foregroundColor: .red
                    )
                    .onTapGesture {
                        showAfterTodayView = true
                    }
                }
            }
            .padding(.horizontal)
            .navigationDestination(isPresented: $showLoadingPage, destination: {
                LoadingPageView(saveStuadyVM: saveStudyVM, study: study)
                    .environmentObject(navState)
            })
        }
        .padding(.vertical)
        .background(
            Group {
                NavigationLink(
                    destination: AfterTodayView(
                        study: study,
                        todayGoal: saveStudyVM.goalText
                    )
                    .environmentObject(saveStudyVM),
                    isActive: $showAfterTodayView
                ) {
                    EmptyView()
                }
            }
        )
        .task {
            navState.showTabBar = true
        }
        .environmentObject(saveStudyVM)
    }
}

// Preview 추가
#Preview {
    SinglePlantMainView(
        study: Study(nickname: "Test", study_name: "Test Study", study_type: 0, meating_num: 0, meating_goal: 10)
    )
    .environmentObject(NavigationState())
}   
