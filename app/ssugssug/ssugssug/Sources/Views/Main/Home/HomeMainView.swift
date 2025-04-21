import SwiftUI

struct HomeMainView: View {
    @ObservedObject var studyViewModel: StudyViewModel
    var body: some View {
        VStack {
            // 스터디 목록
            StudyListView(viewModel: studyViewModel)
        }
        .padding()
        .border(Color.green, width: 2)
        .navigationBarTitleDisplayMode(.inline)

        
    }
}

#Preview {
    HomeMainView(studyViewModel: StudyViewModel())
}
