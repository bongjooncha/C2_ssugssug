import Foundation

/// API 통신 중 발생할 수 있는 오류를 정의하는 열거형
enum APIError: Error {
    /// URL이 유효하지 않은 경우
    case invalidURL
    
    /// 네트워크 요청 실패
    case requestFailed(Error)
    
    /// 서버 응답이 유효하지 않은 경우
    case invalidResponse
    
    /// JSON 디코딩 오류
    case decodingError(Error)
    
    /// 서버에서 반환한 오류 (상태 코드와 메시지 포함)
    case serverError(statusCode: Int, message: String)
    
    /// 유효한 응답이지만 데이터가 없는 경우
    case noData
    
    /// 인증 관련 오류 (토큰 만료 등)
    case authenticationError
    
    /// 내부 서버 오류
    case internalServerError
    
    /// 알 수 없는 오류
    case unknown(Error)
}

// MARK: - LocalizedError
extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "유효하지 않은 URL입니다"
        case .requestFailed(let error):
            return "요청 실패: \(error.localizedDescription)"
        case .invalidResponse:
            return "유효하지 않은 서버 응답입니다"
        case .decodingError(let error):
            return "데이터 변환 오류: \(error.localizedDescription)"
        case .serverError(let statusCode, let message):
            return "서버 오류 (\(statusCode)): \(message)"
        case .noData:
            return "데이터가 없습니다"
        case .authenticationError:
            return "인증 오류가 발생했습니다"
        case .internalServerError:
            return "서버 내부 오류가 발생했습니다"
        case .unknown(let error):
            return "알 수 없는 오류: \(error.localizedDescription)"
        }
    }
}

// MARK: - 오류 파싱 헬퍼
extension APIError {
    /// 서버 에러 메시지 파싱 유틸리티 함수
    static func parseErrorMessage(from jsonString: String) -> String? {
        guard let data = jsonString.data(using: .utf8) else { return nil }
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: String],
               let detail = json["detail"] {
                return detail
            }
            return nil
        } catch {
            return nil
        }
    }
    
    /// HTTP 상태 코드에 따른 적절한 APIError 반환
    static func error(for statusCode: Int, message: String? = nil) -> APIError {
        switch statusCode {
        case 400...499:
            if statusCode == 401 || statusCode == 403 {
                return .authenticationError
            }
            return .serverError(statusCode: statusCode, message: message ?? "클라이언트 오류")
        case 500...599:
            return .internalServerError
        default:
            return .serverError(statusCode: statusCode, message: message ?? "알 수 없는 서버 오류")
        }
    }
}