import SwiftUI

struct SinglePlantHeaderView: View {
    let study: Study
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text(study.study_name)
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
            }
            HStack {
                InfoCard(title: "만남 횟수", value: "\(study.meating_num)/\(study.meating_goal)", backgroundColor: .white, borderColor: Color.gray.opacity(0.2))
                InfoCard(title: "진행률", value: "\(Int((Float(study.meating_num) / Float(study.meating_goal)) * 100))%", backgroundColor: .white, borderColor: Color.gray.opacity(0.2))
            }
            .padding()
        }
    }
}