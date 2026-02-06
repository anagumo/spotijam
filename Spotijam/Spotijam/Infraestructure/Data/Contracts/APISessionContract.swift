import Foundation

protocol APISessionContract {
    /// A generic function to make a request using a session of URLSession
    ///
    /// - Parameter urlRequestComponents: represents request configuration conforming to `(URLRequestContract)`
    /// - Returns: an object of type `(Response)` that represents a decoded object. The expected type is defined by the type conforming this protocol.
    /// - Throws: `(NetworkError)` that represents a server error
    ///
    /// ## Example
    /// ```swift
    /// let tokenDTO = try await apiSession.request(
    ///     LoginURLRequest()
    /// ).data
    /// ```
    func request<T: URLRequestContract>(_ urlRequestComponents: T) async throws -> T.Response
}
