import UIKit

/// Network Data Model for Unsplash API

struct UnsplashData: Codable {
    var id: String
    var createdAt: String
    var width: Int
    var height: Int
    var color: String
    var likes: Int
    var urls: ImageUrls
    var user: UserData
    var caption: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, createdAt, width, height, color, likes, urls, user
        case caption = "description"
    }
}

struct ImageUrls: Codable {
    var raw: String
    var full: String
    var regular: String
    var small: String
    var thumb: String
}

struct UserData: Codable {
    var id: String
    var username: String
    var name: String
    var bio: String?
    var location: String?
    var profileImage: UserImageUrls
    var totalLikes: Int
    var totalPhotos: Int
}

struct UserImageUrls: Codable {
    var small: String
    var medium: String
    var large: String
}
