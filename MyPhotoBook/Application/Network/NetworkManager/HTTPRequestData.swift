import UIKit

/// Request data structure for nework requests.
struct HTTPRequestData {
     let path: String
     let method: HTTPMethod
     let params: [String: String]?
     let headers: [String: String]?
    
    /// Initializer for HTTPRequestData.
    ///
    /// - Parameters:
    ///   - path: url path
    ///   - method: http method
    ///   - params: request parameters
    ///   - headers: request headers.
     init (
        path: String,
        method: HTTPMethod = .get,
        params: [String: String]? = nil,
        headers: [String: String]? = nil
        ) {
        self.path = path
        self.method = method
        self.params = params
        self.headers = headers
    }
}
