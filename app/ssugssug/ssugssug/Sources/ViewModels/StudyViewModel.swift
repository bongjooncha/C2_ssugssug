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
    
    func setUsername(_ username: String) {
        self.username = username
    }
    
    func fetchUserStudies() {
        guard !username.isEmpty else {
            errorMessage = "사용자 이름이 설정되지 않았습니다"
            return
        }
        
        isLoading = true
        errorMessage = nil
        let url = "http://10.141.51.36:8000"
        
        let endpoint = url+"/groups/studies/user/\(username)"
        
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
    
    func fetchUserStudies(username: String) {
        self.username = username
        fetchUserStudies()
    }
    
    func deleteAccount(completion: @escaping (Bool) -> Void) {
        guard !username.isEmpty else {
            completion(false)
            return
        }
        
        let endpoint = "http://localhost:8000/auth/delete-account"
        
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

struct EmptyResponse: Codable {} 
