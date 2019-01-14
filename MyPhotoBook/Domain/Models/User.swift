import UIKit

/// Domain model for User.
struct User {
    var id: String
    var username: String
    var name: String
    var bio: String?
    var location: String?
    var profileImage: String?
    var totalLikes: Int
    var totalPhotos: Int
    var images: [Image]?
}
