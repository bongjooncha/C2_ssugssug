import Foundation
import Combine
import Alamofire

final class AuthViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private let networkService = NetworkService()
    private var cancellables = Set<AnyCancellable>()
    
    func register(nickname: String, password: String, confirmPassword: String) {
        guard password == confirmPassword else {
            self.errorMessage = "비밀번호가 일치하지 않습니다"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        let registerRequest = AuthRequest(nickname: nickname, password: password)
        
        networkService.request(endpoint: "/auth/signup", method: .post, body: registerRequest)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                
                if case .failure(let error) = completion {
                    switch error {
                    case .serverError(_, let message):
                        self?.errorMessage = self?.parseErrorMessage(message) ?? "회원가입 실패"
                    default:
                        self?.errorMessage = "네트워크 오류: \(error.localizedDescription)"
                    }
                }
            } receiveValue: { [weak self] (user: User) in
                self?.currentUser = user
                self?.isAuthenticated = true
            }
            .store(in: &cancellables)
    }
    
    func login(nickname: String, password: String) {
        isLoading = true
        errorMessage = nil
        
        let loginRequest = AuthRequest(nickname: nickname, password: password)
        
        networkService.request(endpoint: "/auth/login", method: .post, body: loginRequest)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
            guard let self else { return }
                self.isLoading = false
                
                if case .failure(let error) = completion {
                    switch error {
                    case .serverError(_, let message):
                        self.errorMessage = self.parseErrorMessage(message) ?? "로그인 실패"
                    default:
                        self.errorMessage = "네트워크 오류: \(error.localizedDescription)"
                    }
                }
            } receiveValue: { [weak self] (user: User) in
                self?.currentUser = user
                self?.isAuthenticated = true
            }
            .store(in: &cancellables)
    }
    
    func logout() {
        self.currentUser = nil
        self.isAuthenticated = false
    }

    func deleteAccount(completion: @escaping (Bool) -> Void) {
        guard let nickname = currentUser?.nickname else {
            completion(false)
            return
        }
        
        isLoading = true
        
        let endpoint = APIEnvironment.current.baseURL + "/auth/users/\(nickname)"
        
        AF.request(endpoint, method: .delete)
            .validate()
            .response { [weak self] response in
                self?.isLoading = false
                
                switch response.result {
                case .success:
                    self?.currentUser = nil
                    self?.isAuthenticated = false
                    completion(true)
                case .failure:
                    completion(false)
                }
            }
    }
    
    private func parseErrorMessage(_ jsonString: String) -> String? {
        guard let data = jsonString.data(using: .utf8) else { return nil }
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String : String],
               let detail = json["detail"] {
                return detail
            }
            return nil
        } catch {
            return nil
        }
    }
} 
