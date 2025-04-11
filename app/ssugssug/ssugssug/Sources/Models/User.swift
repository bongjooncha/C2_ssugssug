import Foundation

struct User: Codable, Identifiable {
    var id: String { nickname }
    let nickname: String
}

struct AuthRequest: Codable {
    let nickname: String
    let password: String
}