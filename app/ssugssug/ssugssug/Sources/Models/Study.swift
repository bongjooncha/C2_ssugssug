import Foundation

struct Study: Codable, Identifiable {
    let nickname: String
    let study_name: String
    let study_type: Int8
    let meating_num: Int8
    let meating_goal: Int8
    
    var id: String { study_name }
    
    var typeString: String {
        switch study_type {
        case 0:
            return "스터디(파)"
        case 1:
            return "문화생활(죽순)"
        case 2:
            return "경험공유(박)"
        default:
            return "기타"
        }
    }
} 
