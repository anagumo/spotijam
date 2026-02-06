import Foundation

enum NetworkError: Error {
    case malformedURL
    case badRequest
    case statusCode
    case decoding
    case unknown
}
