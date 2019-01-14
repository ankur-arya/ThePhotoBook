import UIKit

/// HTTP error types
///
/// - invalidURL: if the url is invalid.
/// - noData: if the url return no data.
enum HTTPError: Swift.Error {
    case invalidURL
    case noData
}
