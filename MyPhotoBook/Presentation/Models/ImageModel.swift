import UIKit

/// Presentation model for Image.
struct ImageModel {
    var user: UserModel
    var likes: String
    var photograph: URL?
    var photographLarge: URL?
    var date: String
    var caption: String
}
