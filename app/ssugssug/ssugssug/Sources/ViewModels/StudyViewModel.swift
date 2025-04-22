import Foundation
import Combine
import Alamofire

class StudyViewModel: ObservableObject {
    @Published var studies: [Study] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var username: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {}
    
    init(username: String) {
        self.username = username
        fetchUserStudies()
    }
    
    func fetchUserStudies() {
        guard !username.isEmpty else {
            errorMessage = "사용자 이름이 설정되지 않았습니다"
            return
        }
        
        isLoading = true
        errorMessage = nil
        let baseURL = APIEnvironment.current.baseURL
        
        let endpoint = baseURL+"/groups/studies/user/\(username)"
        
        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: [Study].self) { [weak self] response in
                guard let self = self else { return }
                
                self.isLoading = false
                
                switch response.result {
                case .success(let studies):
                    self.studies = studies
                

                // 오류 처리
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
    
    func fetchUserStudies(username: String) {
        self.username = username
        fetchUserStudies()
    }
}

struct EmptyResponse: Codable {} 
