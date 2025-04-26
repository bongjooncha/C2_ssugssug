import SwiftUI

struct MemoItem: Identifiable {
    let id = UUID()
    var title: String
    var content: String
}

struct SwipeActionsListView: View {
    @State private var memos = [
        MemoItem(title: "메모 1", content: "오늘 물 주기"),
        MemoItem(title: "메모 2", content: "화분 옮기기"),
        MemoItem(title: "메모 3", content: "비료 주기"),
        MemoItem(title: "메모 4", content: "가지치기 하기")
    ]
    
    @State private var editingMemo: MemoItem?
    @State private var isEditingSheetPresented = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(memos) { memo in
                    VStack(alignment: .leading) {
                        Text(memo.title)
                            .font(.headline)
                        Text(memo.content)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 5)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            deleteMemo(memo)
                        } label: {
                            Label("삭제", systemImage: "trash")
                        }
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            editingMemo = memo
                            isEditingSheetPresented = true
                        } label: {
                            Label("수정", systemImage: "pencil")
                        }
                        .tint(.blue)
                    }
                }
            }
            .navigationTitle("메모 목록")
            .sheet(isPresented: $isEditingSheetPresented) {
                if let memo = editingMemo {
                    TryEditMemoView(memo: memo) { updatedTitle, updatedContent in
                        if let index = memos.firstIndex(where: { $0.id == memo.id }) {
                            memos[index].title = updatedTitle
                            memos[index].content = updatedContent
                        }
                    }
                }
            }
        }
    }
    
    func deleteMemo(_ memo: MemoItem) {
        if let index = memos.firstIndex(where: { $0.id == memo.id }) {
            memos.remove(at: index)
        }
    }
}

struct TryEditMemoView: View {
    let memo: MemoItem
    let onSave: (String, String) -> Void
    
    @State private var title: String
    @State private var content: String
    @Environment(\.dismiss) private var dismiss
    
    init(memo: MemoItem, onSave: @escaping (String, String) -> Void) {
        self.memo = memo
        self.onSave = onSave
        _title = State(initialValue: memo.title)
        _content = State(initialValue: memo.content)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("제목", text: $title)
                TextField("내용", text: $content)
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
                        onSave(title, content)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SwipeActionsListView()
}
