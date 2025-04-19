import SwiftUI

struct StudyListView: View {
    @ObservedObject var viewModel: StudyViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("기르고 있는 식물: ")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, 5)

            if viewModel.studies.isEmpty && !viewModel.isLoading {
                Text("기르고 있는 식물이 없습니다")
                    .font(.body)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 40)
            } else {
                List {
                    ForEach(viewModel.studies) { study in
                        VStack(alignment: .leading, spacing: 2) {
                            Text(study.study_name)
                                .font(.headline)
                            
                            HStack {
                                Text(study.typeString)
                                    .font(.subheadline)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 2)
                                    .background(study.study_type == 0 ? Color.blue.opacity(0.2) : Color.green.opacity(0.2))
                                    .cornerRadius(4)
                                
                                Spacer()
                                
                                Text("진행: \(study.meating_goal)/\(study.meating_num)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .padding(.leading, -10)
            }
        }
    }
}

#Preview {
    StudyListView(viewModel: StudyViewModel())
} 