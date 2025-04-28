import Foundation

// JSON 응답 구조
struct MemoResponse: Codable {
    var memos: [Memo]
}

// 메모 저장소 서비스
class MemoStorage {
    private let fileManager = FileManager.default
    private var documentsURL: URL {
        fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private var memoFileURL: URL {
        documentsURL.appendingPathComponent("memos.json")
    }
    
    // 번들에 있는 템플릿 파일 URL
    private var templateURL: URL? {
        Bundle.main.url(forResource: "memo", withExtension: "json")
    }
    
    // 모든 메모 읽기
    func loadAllMemos() -> [Memo] {
        // 파일이 없으면 생성
        if !fileManager.fileExists(atPath: memoFileURL.path) {
            createMemoFileIfNeeded()
        }
        
        do {
            let data = try Data(contentsOf: memoFileURL)
            let memoResponse = try JSONDecoder().decode(MemoResponse.self, from: data)
            return memoResponse.memos
        } catch {
            return []
        }
    }
    
    // 특정 스터디의 메모만 읽기
    func loadMemos(forStudy studyName: String) -> [Memo] {
        let allMemos = loadAllMemos()
        let filteredMemos = allMemos.filter { $0.study_name == studyName }
        
        // 날짜 변환 및 정렬을 위한 준비
        let dateFormatter = ISO8601DateFormatter()
        
        // 날짜순으로 정렬된 메모 반환
        return filteredMemos.sorted { memo1, memo2 in
            if let date1 = dateFormatter.date(from: memo1.date),
               let date2 = dateFormatter.date(from: memo2.date) {
                return date1 > date2 // 최신 날짜가 먼저 오도록 정렬
            }
            return false
        }
    }
    
    // 메모 저장
    func saveMemos(_ memos: [Memo]) -> Bool {
        do {
            let memoResponse = MemoResponse(memos: memos)
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            let data = try encoder.encode(memoResponse)
            try data.write(to: memoFileURL)
            return true
        } catch {
            return false
        }
    }
    
    // 메모 추가
    func addMemo(username: String, study_name: String, goal: String, imp: String) -> Bool {
        let dateFormatter = ISO8601DateFormatter()
        let currentDate = dateFormatter.string(from: Date())
        
        // 기존 Memo 모델 사용
        let newMemo = Memo(
            username: username,
            study_name: study_name,
            date: currentDate,
            goal: goal,
            imp: imp
        )
        
        var memos = loadAllMemos()
        memos.append(newMemo)
        return saveMemos(memos)
    }
    
    // 메모 수정 (id가 String이므로 String 타입으로 변경)
    func updateMemo(_ updatedMemo: Memo) -> Bool {
        var memos = loadAllMemos()
        if let index = memos.firstIndex(where: { $0.id == updatedMemo.id }) {
            memos[index] = updatedMemo
            return saveMemos(memos)
        }
        return false
    }
    
    // 메모 삭제 (id가 String이므로 String 타입으로 변경)
    func deleteMemo(withId id: String) -> Bool {
        var memos = loadAllMemos()
        memos.removeAll { $0.id == id }
        return saveMemos(memos)
    }
    
    // 특정 스터디의 모든 메모 삭제
    func deleteAllMemos(forStudy studyName: String) -> Bool {
        var memos = loadAllMemos()
        memos.removeAll { $0.study_name == studyName }
        return saveMemos(memos)
    }
    
    // 필요시 메모 파일 생성
    private func createMemoFileIfNeeded() {
        // 템플릿이 있으면 복사, 없으면 빈 구조 생성
        if let templateURL = templateURL {
            do {
                let data = try Data(contentsOf: templateURL)
                try data.write(to: memoFileURL)
            } catch {
                createEmptyMemoFile()
            }
        } else {
            createEmptyMemoFile()
        }
    }
    
    // 빈 메모 파일 생성
    private func createEmptyMemoFile() {
        let emptyResponse = MemoResponse(memos: [])
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        if let data = try? encoder.encode(emptyResponse) {
            try? data.write(to: memoFileURL)
        }
    }
}
