import SwiftUI

struct HomeView: View {
    @State private var showCreateStudy = false


        var body: some View {
            NavigationStack {
                VStack(spacing: 10) {
                    Spacer()
                }
                .padding()
                .navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $showCreateStudy) {
            }
        }
    }
}


#Preview {
    HomeView()
}
