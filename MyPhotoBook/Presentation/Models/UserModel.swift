import UIKit

/// Presentation Model for User.
struct UserModel {
    var id: String
    var username: String
    var name: String
    var bio: String?
    var location: String?
    var profileImage: URL?
    var totalLikes: String
    var totalPhotos: String
    var images: [ImageModel]?
}

