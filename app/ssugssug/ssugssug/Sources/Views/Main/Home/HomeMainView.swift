import SwiftUI

struct HomeMainView: View {
    @ObservedObject var studyViewModel: StudyViewModel
    var body: some View {
        VStack {
            // 스터디 목록
            StudyListView(viewModel: studyViewModel)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

