import SwiftUI

struct HomeMainView: View {
    @ObservedObject var studyViewModel: StudyViewModel
    @State private var showStudyPicker = false
    @State private var selectedStudy: Study?
    @State private var navigateToSinglePlant = false
    
    var body: some View {
        NavigationStack{
            VStack {
                if studyViewModel.studies.isEmpty {
                    Ground(nil, 25, .brown, 100)
                        .frame(width: 320, height: 200)
                        .padding(.vertical, 100)
                
                    Text("식물이 없습니다. 스터디를 추가해보세요.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    Ground(1, 25, .brown, 100)
                        .frame(width: 350, height: 200)
                        .padding(.vertical, 100)

                    Button(action: {
                        showStudyPicker = true
                    }) {
                        HStack {
                            Image(systemName: "leaf.fill")
                                .foregroundColor(.green)
                            Text("내 식물 선택하기")
                                .foregroundColor(.green)
                                .fontWeight(.semibold)
                        }
                        .padding()
                        .frame(width: 200)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .padding()
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .actionSheet(isPresented: $showStudyPicker) {
                ActionSheet(
                    title: Text("식물 선택"),
                    message: Text("보고 싶은 식물을 선택하세요"),
                    buttons: studyButtonList()
                )
            }
            .background(
                NavigationLink(
                    destination: Group {
                        if let study = selectedStudy {
                            SinglePlantView(study: study)
                        }
                    },
                    isActive: $navigateToSinglePlant
                ) {
                    EmptyView()
                }
            )
        }
    }
    
    private func studyButtonList() -> [ActionSheet.Button] {
        var buttons: [ActionSheet.Button] = studyViewModel.studies.map { study in
            .default(Text(study.study_name)) {
                self.selectedStudy = study
                self.navigateToSinglePlant = true
            }
        }
        
        buttons.append(.cancel(Text("취소")))
        return buttons
    }
}

#Preview {
    HomeMainView(studyViewModel: StudyViewModel(username: "Test2"))
}
