import SwiftUI

struct SinglePlantView: View {
    let study: Study
    @Environment(\.presentationMode) var presentationMode
    @State private var showMemoView = false
    @Binding var navBarHidden: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            SinglePlantHeaderView(study: study)
            SinglePlantMainView(study: study, navBarHidden: $navBarHidden)
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

    SinglePlantView(study: previewStudy, navBarHidden: .constant(false))
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
