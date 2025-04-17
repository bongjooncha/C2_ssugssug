import Foundation
import Combine
import Alamofire

class StudyViewModel: ObservableObject {
    @Published var studies: [Study] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchUserStudies(username: String) {
        isLoading = true
        errorMessage = nil
        
        let endpoint = "http://localhost:8000/groups/studies/user/\(username)"
        
        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: [Study].self) { [weak self] response in
                guard let self = self else { return }
                
                self.isLoading = false
                
                switch response.result {
                case .success(let studies):
                    self.studies = studies
                    
                case .failure(let error):
                    if let data = response.data, 
                       let errorString = String(data: data, encoding: .utf8) {
                        self.errorMessage = "서버 오류: \(errorString)"
                    } else if let afError = error.asAFError {
                        switch afError {
                        case .responseValidationFailed:
                            self.errorMessage = "서버 응답이 올바르지 않습니다"
                        case .responseSerializationFailed:
                            self.errorMessage = "데이터 형식이 올바르지 않습니다"
                        default:
                            self.errorMessage = "네트워크 오류: \(error.localizedDescription)"
                        }
                    } else {
                        self.errorMessage = "스터디 정보를 불러오는데 실패했습니다"
                    }
                }
            }
    }
    
    func deleteAccount(completion: @escaping (Bool) -> Void) {
        let endpoint = "http://localhost:8000/auth/delete-account" // 실제 API 엔드포인트로 변경해야 합니다
        
        AF.request(endpoint, method: .delete)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(true)
                case .failure:
                    completion(false)
                }
            }
    }
}

// 응답 데이터가 없는 API 호출을 위한 빈 응답 타입
struct EmptyResponse: Codable {} 