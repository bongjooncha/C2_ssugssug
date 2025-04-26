import SwiftUI

struct MemoView: View {
    let study: Study
    private let memoStorage = MemoStorage()
    @State private var memos: [Memo] = []
    @State private var editingMemo: Memo?
    @State private var isEditingSheetPresented = false
    
    private func loadMemos() {
        self.memos = memoStorage.loadMemos(forStudy: study.study_name)
    }
    
    var body: some View {
        VStack {           
            Text("\(study.study_name) 메모")
                .font(.title)
                .padding()
            
            if memos.isEmpty {
                Spacer()
                Text("메모가 없습니다.")
                    .foregroundColor(.gray)
                Spacer()
            } else {
                List {
                    ForEach(memos, id: \.id) { memo in
                        MemoItemView(memo: memo)
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
            }
        }
        .navigationTitle("메모")
        .onAppear {
            loadMemos()
        }
        .sheet(isPresented: $isEditingSheetPresented) {
            if let memo = editingMemo {
                NavigationStack {
                    EditMemoView(memo: memo) { updatedGoal, updatedImp in
                        // Memo의 속성이 let으로 선언되어 있으므로 새 Memo 객체를 생성해야 함
                        let updatedMemo = Memo(
                            username: memo.username,
                            study_name: memo.study_name,
                            date: memo.date,
                            goal: updatedGoal,
                            imp: updatedImp
                        )
                        
                        if memoStorage.updateMemo(updatedMemo) {
                            loadMemos() // 데이터 새로고침
                        }
                    }
                }
            }
        }
    }
    
    private func deleteMemo(_ memo: Memo) {
        if memoStorage.deleteMemo(withId: memo.id) {
            loadMemos() // 삭제 후 목록 새로고침
        }
    }
}

#Preview {
    MemoView(study: Study(
        nickname: "사용자",
        study_name: "코딩 테스트", // JSON 파일에 있는 스터디 이름 사용
        study_type: 0,
        meating_num: 13,
        meating_goal: 20
    )
    )
}
