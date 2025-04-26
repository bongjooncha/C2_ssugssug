import SwiftUI

struct EditMemoView: View {
    let memo: Memo
    let onSave: (String, String) -> Void
    
    @State private var goal: String
    @State private var impression: String
    @Environment(\.dismiss) private var dismiss
    
    init(memo: Memo, onSave: @escaping (String, String) -> Void) {
        self.memo = memo
        self.onSave = onSave
        _goal = State(initialValue: memo.goal)
        _impression = State(initialValue: memo.imp)
    }
    
    var body: some View {
        Form {
            Section(header: Text("메모 정보")) {
                Text(memo.formattedDate)
                    .foregroundColor(.gray)
                
                VStack(alignment: .leading) {
                    Text("목표").font(.caption).foregroundColor(.gray)
                    TextField("목표를 입력하세요", text: $goal)
                        .padding(8)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(8)
                }
                .padding(.vertical, 4)
                
                VStack(alignment: .leading) {
                    Text("느낀점").font(.caption).foregroundColor(.gray)
                    TextEditor(text: $impression)
                        .frame(minHeight: 100)
                        .padding(8)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(8)
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle("메모 수정")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("취소") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button("저장") {
                    onSave(goal, impression)
                    dismiss()
                }
            }
        }
        .onAppear {
            // 키보드가 TextField를 가리지 않도록 하는 설정
            UITextView.appearance().backgroundColor = .clear
        }
    }
}

struct EditMemoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EditMemoView(memo: Memo(
                username: "사용자",
                study_name: "스터디",
                date: ISO8601DateFormatter().string(from: Date()),
                goal: "목표 달성하기",
                imp: "노력하면 할 수 있다!"
            ), onSave: { _, _ in })
        }
    }
}
