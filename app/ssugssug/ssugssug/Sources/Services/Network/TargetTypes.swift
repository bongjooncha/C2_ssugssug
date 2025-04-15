extension APIService: TargetType {
    var baseURL: URL {
        return URL(string: "http://localhost:8000")!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .signup:
            return "/auth/signup"
        // 다른 경로들...
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .signup:
            return .post
        // 다른 HTTP 메서드들...
        }
    }
    
    var task: Task {
        switch self {
        case let .login(nickname, password):
            return .requestParameters(
                parameters: ["nickname": nickname, "password": password],
                encoding: JSONEncoding.default
            )
        case let .signup(nickname, password):
            return .requestParameters(
                parameters: ["nickname": nickname, "password": password],
                encoding: JSONEncoding.default
            )
        // 다른 요청 타입들...
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}