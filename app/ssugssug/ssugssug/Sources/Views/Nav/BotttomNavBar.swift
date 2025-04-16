import SwiftUI

struct BottomNavBar: View {
    @Binding var selectedTab: Int
    
    private struct TabItem {
        let index: Int
        let title: String
        let iconName: String
        
        var selectedIconName: String {
            return iconName + ".fill"
        }
    }
    
    private let tabs = [
        TabItem(index: 0, title: "내 화단", iconName: "leaf"),
        TabItem(index: 1, title: "전체 화단", iconName: "tree"),
        TabItem(index: 2, title: "설정", iconName: "gearshape")
    ]
    
    var body: some View {
        HStack {
            Spacer()
            
            ForEach(tabs, id: \.index) { tab in
                TabButton(
                    title: tab.title,
                    iconName: selectedTab == tab.index ? tab.selectedIconName : tab.iconName,
                    isSelected: selectedTab == tab.index,
                    action: { selectedTab = tab.index }
                )
                
                Spacer()
            }
        }
        .padding(.vertical, 10)
        .background(Color(.systemBackground))
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray.opacity(0.3)),
            alignment: .top
        )
    }
}

struct TabButton: View {
    let title: String
    let iconName: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .font(.system(size: 22))
            Text(title)
                .font(.caption)
        }
        .foregroundColor(isSelected ? .green : .gray)
        .onTapGesture(perform: action)
    }
}

#Preview {
    VStack {
        Spacer()
        BottomNavBar(selectedTab: .constant(0))
    }
}
