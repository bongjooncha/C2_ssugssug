import SwiftUI

struct AfterTodayView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var navState: NavigationState
    @EnvironmentObject var saveStudyVM: SaveStudyViewModel
    @State private var impression: String = ""
    @State private var navigateBack = false
    
    var study: Study
    var todayGoal: String
    
    // MemoStorage 인스턴스 생성
    let memoStorage = MemoStorage()
    
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
                        Text("뒤로 가기")
                    }
                    .foregroundColor(.green)
                }
                .padding(.top, 10)
                .padding(.leading, 16)
                
                Text("오늘의 목표:")
                    .font(.headline)
                    .padding(.leading, 16)
                
                Text(todayGoal)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                
                Text("느낀 점:")
                    .font(.headline)
                    .padding(.leading, 16)
                    .padding(.top, 10)
                
                // 텍스트 입력 필드
                TextField("", text: $impression)
                    .frame(height: 200)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                
                Spacer()
                
                // 다음 버튼 (우측 하단)
                HStack {
                    Spacer()
                    Button(action: {
                        // 메모 저장 및 홈으로 돌아가기
                        saveStudyVM.saveImpression(impression)
                        
                        // 메모 저장 - MemoStorage 싱글톤 대신 직접 인스턴스 사용
                        memoStorage.addMemo(
                            username: study.nickname,
                            study_name: study.study_name,
                            goal: todayGoal,
                            imp: impression
                        )
                        
                        // 스터디 상태 초기화
                        saveStudyVM.resetStudy()
                        navigateBack = true
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
        .onAppear {
            navState.showTabBar = false
        }
        .background(
            NavigationLink(
                destination: SinglePlantView(study: study).environmentObject(navState),
                isActive: $navigateBack,
                label: { EmptyView() }
            )
        )
    }
}

#Preview {
    AfterTodayView(
        study: Study(nickname: "Test", study_name: "Test Study", study_type: 0, meating_num: 0, meating_goal: 10),
        todayGoal: "테스트 목표"
    )
    .environmentObject(NavigationState())
    .environmentObject(SaveStudyViewModel())
}
