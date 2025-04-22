import Foundation

struct Memo: Codable, Identifiable {
    let username: String
    let study_name: String
    let date: String
    let goal: String
    let imp: String
    
    // Identifiable 프로토콜 요구사항을 위한 id (date + study_name 조합으로 고유성 확보)
    var id: String {
        return date + study_name
    }
    
    // 보기 좋은 날짜 형식으로 변환
    var formattedDate: String {
        if let isoDate = ISO8601DateFormatter().date(from: date) {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            formatter.locale = Locale(identifier: "ko_KR")
            return formatter.string(from: isoDate)
        }
        return date
    }
}