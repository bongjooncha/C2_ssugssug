import SwiftUI

struct MemoItemView: View {
    let memo: Memo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(memo.formattedDate)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
            }
            
            Text("목표: \(memo.goal)")
                .font(.headline)
                .padding(.vertical, 4)
            
            Text("느낀점: \(memo.imp)")
                .font(.body)
                .lineLimit(3)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}