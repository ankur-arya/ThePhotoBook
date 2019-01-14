import UIKit

/// HTTP request methods.
///
/// - get: for get requests.
/// - post: for post requests.
/// - put: for put requests.
/// - patch: for patch requests.
/// - delete: for delete requests.
enum HTTPMethod : String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}
