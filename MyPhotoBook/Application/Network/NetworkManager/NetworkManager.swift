import UIKit

/// struct for fetching unsplashFeed from server.
struct FetchImagesFromServer: HTTPRequestType {
    typealias HTTPResponseType = [UnsplashData]
    var params: [String: String]?
    var data: HTTPRequestData {
        return HTTPRequestData(path: DataEndpoint.unsplashFeed.rawValue, params: params)
    }
}

/// struct for fetching unsplashFeed from server.
struct FetchUserFromServer: HTTPRequestType {
    typealias HTTPResponseType = [UnsplashData]
    var params: [String: String]?
    var username: String
    var data: HTTPRequestData {
        return HTTPRequestData(path: DataEndpoint.userFeed.rawValue + username + "/photos?", params: params)
    }
}

/// struct for fetching image from url.
struct FetchImageFromURL: HTTPDataRequestType {
    var url: String
    var data: HTTPRequestData {
        return HTTPRequestData(path: url)
    }
}

class NetworkManager {
    
    /// Set cache for network calls.
    class func setCaching() {
        let memoryCap = 150 * 1024 * 1024 // 150 MB
        let diskCap = 300 * 1024 * 1024 // 300 MB
        let urlCache = URLCache(memoryCapacity: memoryCap, diskCapacity: diskCap, diskPath: "MyPhotoBookCache")
        URLCache.shared = urlCache
    }
}
