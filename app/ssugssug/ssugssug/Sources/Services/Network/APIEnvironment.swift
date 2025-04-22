import Foundation

enum APIEnvironment {
    case development
    case staging
    case production
    
    var baseURL: String {
        switch self {
        case .development:
            // return "http://localhost:8000"
            return "http://10.141.51.36:8000"
        case .staging:
            return "http://10.141.51.36:8000"
        case .production:
            return "http://localhost:8000"
        }
    }
    
    // 현재 환경 설정
    static var current: APIEnvironment {
        #if DEBUG
        return .development
        #else
        return .production
        #endif
    }
}
