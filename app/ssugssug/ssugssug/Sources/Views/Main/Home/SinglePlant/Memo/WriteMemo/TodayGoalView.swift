import SwiftUI

struct TodayGoalView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var todayGoal: String = ""
    @EnvironmentObject var saveStudyVM: SaveStudyViewModel
    @State private var navigateBackToMain = false
    
    var study: Study
    
    var body: some View {
        ZStack {
            // 배경색
            Color(red: 0.95, green: 0.95, blue: 0.9)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 20) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("뒤로")
                    }
                    .foregroundColor(.green)
                }
                .padding(.top, 10)
                .padding(.leading, 16)
                
                // 오늘의 목표 입력 영역
                VStack(alignment: .leading, spacing: 10) {
                    Spacer()
                    Text("오늘의 목표:")
                        .font(.headline)
                        .padding(.leading, 16)
                    
                    // 텍스트 입력 필드
                    TextField("", text: $todayGoal)
                        .frame(height: 70)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 16)
                    Spacer()
                }
                .padding(.top, 20)
                
                Spacer()
                
                // 다음 버튼 (우측 하단)
                HStack {
                    Spacer()
                    Button(action: {
                        // 목표 저장하고 메인 화면으로 돌아가기
                        saveStudyVM.saveGoal(todayGoal)
                        saveStudyVM.studyState = .inProgress
                        navigateBackToMain = true
                    }) {
                        Text("다음")
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 8)
                            .background(Color.green)
                            .cornerRadius(20)
                    }
                    .padding(.trailing, 16)
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationBarHidden(true)
        .background(
            NavigationLink(
                destination: SinglePlantView(study: study),
                isActive: $navigateBackToMain,
                label: { EmptyView() }
            )
        )
    }
}

//#Preview {
//    TodayGoalView(study: Study(nickname: "Test User", study_name: "Test Study"))
//        .environmentObject(NavigationState())
//        .environmentObject(SaveStudyViewModel())
//}
