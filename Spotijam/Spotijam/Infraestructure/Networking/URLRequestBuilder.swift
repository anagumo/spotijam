import Foundation

final class URLRequestBuilder<T: URLRequestContract> {
    private let urlRequestComponents: T
    
    init(_ urlRequestComponents: T) {
        self.urlRequestComponents = urlRequestComponents
    }
    
    /// Implements the URL creation that contains a scheme, host, path and query parameters
    /// - Returns: an object of type `(URL)` that represents a url to load
    /// - Throws: `(NetworkError)` that represents a malformedURL
    private func buildURL() throws -> URL {
        var urlComponents: URLComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = urlRequestComponents.host
        urlComponents.path = urlRequestComponents.path
        
        if !urlRequestComponents.queryParameters.isEmpty {
            urlComponents.queryItems = urlRequestComponents
                .queryParameters
                .map {
                    URLQueryItem(name: $0.key, value: $0.value)
                }
        }
        
        guard let url = urlComponents.url else {
            throw NetworkError.malformedURL
        }
        return url
    }
    
    /// Implements a URLRequest that contains a URL, httpMethod, headers and body
    /// - Returns: an object of type `(URLRequest)` that represents a request to the server
    /// - Throws: `(NetworkError)` that represents a bad request
    func build() throws -> URLRequest {
        do {
            var urlRequest = try URLRequest(url: buildURL())
            urlRequest.httpMethod = urlRequestComponents.method.rawValue
            urlRequest.allHTTPHeaderFields = [
                "Content-Type": "application/json; charset=utf-8",
                "Accept": "*/*"
            ].merging(urlRequestComponents.headers) { $1 }
            
            if let body = urlRequestComponents.body {
                urlRequest.httpBody = try JSONEncoder().encode(body)
            }
            return urlRequest
        } catch {
            throw NetworkError.badRequest
        }
    }
}
