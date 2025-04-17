import Foundation

struct Study: Codable, Identifiable {
    let nickname: String
    let study_name: String
    let study_type: Int
    let meating_num: Int
    let meating_goal: Int
    
    var id: String { study_name }
    
    var typeString: String {
        return study_type == 0 ? "개인" : "그룹"
    }
} 