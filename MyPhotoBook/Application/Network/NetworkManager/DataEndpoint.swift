import UIKit

/// HTTP endpoint urls.
///
/// - unsplashFeed: unsplash feed api endpoint.
/// - userFeed: user feed api endpoint.
enum DataEndpoint: String {
    case unsplashFeed = "https://api.unsplash.com/photos?"
    case userFeed = "https://api.unsplash.com/users/"
}

