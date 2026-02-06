import Foundation

final class APISession: APISessionContract {
    static let shared = APISession()
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func request<T>(_ urlRequestComponents: T) async throws -> T.Response where T : URLRequestContract {
        do {
            // Step 1: Build the request using the Builder patern
            let urlRequest = try URLRequestBuilder(urlRequestComponents).build()
            // Step 2: Make a call
            let (data, response) = try await urlSession.data(for: urlRequest)
            // Step 3: Get the status code of the response
            guard let statusCode = response as? HTTPURLResponse else {
                throw NetworkError.statusCode
            }
            // Step 4: Handle success response or error based on the status code
            switch statusCode.statusCode {
            case 200..<300:
                do {
                    // Step 5: Decode the data
                    let decodedData = try JSONDecoder().decode(T.Response.self, from: data)
                    return decodedData
                } catch {
                    throw NetworkError.decoding
                }
            case 401:
                // TODO: Get a new access token
            default:
                throw NetworkError.unknown
            }
        } catch {
            throw NetworkError.badRequest
        }
    }
}
