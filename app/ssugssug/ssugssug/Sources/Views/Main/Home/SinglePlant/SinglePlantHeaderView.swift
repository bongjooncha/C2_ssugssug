import SwiftUI

struct SinglePlantHeaderView: View {
    let study: Study
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text(study.study_name)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading, 20)
                
                Spacer()
            }
            HStack {
                InfoCard(title: "진행률:", percent: "\(Int((Float(study.meating_num) / Float(study.meating_goal)) * 100))%",
                 amount: "(\(study.meating_num)/\(study.meating_goal))", backgroundColor: .white, borderColor: Color.gray.opacity(0.2))
                NavigationLink(destination: MemoView(study: study)) {
                    ActionButton(
                        title: "메모 보기",
                        backgroundColor: Color.yellow.opacity(0.2),
                        foregroundColor: .brown
                    )
                }
            }
            .padding()
        }
    }
}
