import SwiftUI

struct SinglePlantView: View {
    let study: Study
    @Environment(\.presentationMode) var presentationMode
    @State private var showMemoView = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            SinglePlantHeaderView(study: study)
            SinglePlantMainView(study: study)
                .padding(.top, -30)
            Spacer()
        }
        .navigationBarHidden(true)
    }
}



#Preview {
    let previewStudy = Study(
        nickname: "사용자", 
        study_name: "알고리즘 스터디", 
        study_type: 0, 
        meating_num: 4,
        meating_goal: 10 
    )
    
    SinglePlantView(study: previewStudy)
}

struct PlantInfoView: View {
    let study: Study
    @State private var showMemoView = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            // 하단 버튼 (2개 나란히)
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
                    // TODO: 스터디 시작 기능 구현
                    // showStartStudyView = true
                }
                
                /* 나중에 구현할 코드
                .background(
                    NavigationLink(
                        destination: StartStudyView(study: study),
                        isActive: $showStartStudyView
                    ) {
                        EmptyView()
                    }
                )
                */
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
    }
}


// 액션 버튼 컴포넌트
struct ActionButton: View {
    let title: String
    let backgroundColor: Color
    let foregroundColor: Color
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(foregroundColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(backgroundColor)
            .cornerRadius(10)
    }
}


// 미리보기
struct PlantInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PlantInfoView(study: Study(
                nickname: "사용자",
                study_name: "알고리즘 스터디",
                study_type: 0,
                meating_num: 13,
                meating_goal: 20
            ))
        }
    }
}