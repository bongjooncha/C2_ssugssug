import SwiftUI

struct SinglePlantView: View {
    let study: Study
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showMemoView = false
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("뒤로")
                }
                .foregroundColor(.green)
                .padding(.leading, 16)
                .padding(.top, 10)
            }
            SinglePlantHeaderView(study: study)
                .padding(.top, 10)
            SinglePlantMainView(study: study)
                .padding(.top, -30)
            Spacer()
        }
           .navigationBarBackButtonHidden(true)
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
