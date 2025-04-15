import Foundation
import Combine

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}
//rxSwift -> 비동기 처리를 하는 라이브러리 (외부)
enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
    case serverError(Int, String)
}

final class NetworkService {
    // private let baseURL = "http://10.141.51.36:8000"
    private let baseURL = "http://localhost:8000"
    
    //TODO: url configuration
    func request<T: Decodable, U: Encodable>(
        endpoint: String,
        method: HTTPMethod,
        body: U? = nil
    ) -> AnyPublisher<T, NetworkError> {
        
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = body {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                return Fail(error: NetworkError.requestFailed(error)).eraseToAnyPublisher()
            }
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                
                if (200...299).contains(httpResponse.statusCode) {
                    return data
                } else {
                    let errorMessage = String(data: data, encoding: .utf8) ?? "알 수 없는 오류"
                    throw NetworkError.serverError(httpResponse.statusCode, errorMessage)
                }
            }
            .mapError { error -> NetworkError in
                if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return NetworkError.requestFailed(error)
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                if let decodingError = error as? DecodingError {
                    return NetworkError.decodingError(decodingError)
                } else {
                    return error as! NetworkError
                }
            }
            .eraseToAnyPublisher()
    }
} 
