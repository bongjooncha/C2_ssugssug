import SwiftUI

struct MemoView: View {
    let study: Study
    private let memoStorage = MemoStorage()
    @State private var memos: [Memo] = []
    
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
                    ForEach(memos.indices, id: \.self) { index in
                        MemoItemView(memo: memos[index])
                    }
                }
            }
        }
        .navigationTitle("메모")
        .onAppear {
            loadMemos()
        }
    }
}

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

#Preview {
    MemoView(study: Study(
        nickname: "사용자",
        study_name: "tt", // JSON 파일에 있는 스터디 이름 사용
        study_type: 0,
        meating_num: 13,
        meating_goal: 20
    )
    )
}
