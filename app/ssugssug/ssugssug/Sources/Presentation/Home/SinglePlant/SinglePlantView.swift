import SwiftUI

struct SinglePlantView: View {
    let study: Study
    
    @State private var showMemoView = false
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("뒤로")
                }
                .foregroundColor(.green)
                .padding(.leading, 16)
                .padding(.top, 10)
            }
            Spacer()
        }
    }
}

// #Preview {
//     let previewStudy = Study(
//         nickname: "사용자",
//         study_name: "알고리즘 스터디",
//         study_type: 0,
//         meating_num: 4,
//         meating_goal: 10
//     )

//     SinglePlantView(study: previewStudy)
// }
