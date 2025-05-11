import SwiftUI

struct SettingView: View {
    var body: some View {
        NavigationStack {
            NavigationView {
                ZStack{
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("내 정보")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        // 스터디 목록
                        // StudyListView(viewModel: viewModel)
                        //     .padding(.leading, 8)
                        
                        
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
                }
            }
        }
    }
}


#Preview {
    SettingView()
}
