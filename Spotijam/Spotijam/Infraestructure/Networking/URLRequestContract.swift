import Foundation

protocol URLRequestContract {
    // For URL Components
    var host: String { get }
    var path: String { get }
    var queryParameters: [String: String] { get }
    // For URL Request
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var body: Encodable? { get }
    // For HTTP response
    associatedtype Response: Decodable
}

// MARK: Extension to set default values
extension URLRequestContract {
    var host: String { "accounts.spotify.com" } //or { "api.spotify.com/v1" }
    var queryParameters: [String: String] { [:] }
    var headers: [String: String] { [:] }
    var body: Encodable? { nil }
}
