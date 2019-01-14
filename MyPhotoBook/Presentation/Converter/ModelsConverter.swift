import UIKit

/// Converter Class for the models used in this project.
class ModelsConverter {
    
    /// Convert domain Image model to presentation image model.
    ///
    /// - Parameter image: domain image model
    /// - Returns: presentation image model.
    internal func convertImageToImageModel(image: Image) -> ImageModel {
        return ImageModel(user: convertUserToUserModel(user: image.user), likes: image.likes, photograph: URL(string: image.photograph), photographLarge: URL(string: image.photographLarge), date: toPrettyDate(image.date), caption: image.caption)
    }
    
    /// Convert domain user model to presentation user model.
    ///
    /// - Parameter user: domain user model
    /// - Returns: presentation user model.
    internal func convertUserToUserModel(user: User) -> UserModel {
        return UserModel(id: user.id, username: user.username, name: user.name, bio: user.bio, location: user.location, profileImage: URL(string: user.profileImage ?? ""), totalLikes: "\(user.totalLikes)", totalPhotos: "\(user.totalPhotos)", images: user.images?.map({self.convertImageToImageModel(image: $0)}))
    }
    
    /// Convert network model to domain image model.
    ///
    /// - Parameter unsplashModel: network model
    /// - Returns: domain image model.
    internal func convertUnsplashToImage(from unsplashModel: UnsplashData) -> Image {
        return Image(user: convertUserDataToUser(from: unsplashModel.user), likes: "\(unsplashModel.likes)", photograph: unsplashModel.urls.small, photographLarge: unsplashModel.urls.regular, date: unsplashModel.createdAt, caption: unsplashModel.caption ?? "")
    }
    
    /// Convert network model to domain user model.
    ///
    /// - Parameter unsplashModel: network model
    /// - Returns: domain user model.
    private func convertUserDataToUser(from user: UserData) -> User {
        return User(id: user.id, username: user.username, name: user.name, bio: user.bio, location: user.location, profileImage: user.profileImage.large, totalLikes: user.totalLikes, totalPhotos: user.totalPhotos, images: nil)
    }
    
    /// Convert network model array to domain user model.
    ///
    /// - Parameter unsplashModel: network model array
    /// - Returns: domain user model.
    internal func convertUnsplashToUserModel(from unsplashModel: [UnsplashData]) -> User? {
        if let userData = unsplashModel.first {
            let images = unsplashModel.map({self.convertUnsplashToImage(from: $0)})
            let user = User(id: userData.user.id, username: userData.user.username, name: userData.user.name, bio: userData.user.bio, location: userData.user.bio, profileImage: userData.user.profileImage.large, totalLikes: userData.user.totalLikes, totalPhotos: userData.user.totalPhotos, images: images)
            return user
        }
        return nil
    }
    
    /// Format raw date string
    ///
    /// - Parameter uglyDate: raw date string.
    /// - Returns: pretty date string.
    private func toPrettyDate(_ uglyDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "MMMM. d. yyyy"
        
        if let date = dateFormatter.date(from: uglyDate) {
            return newDateFormatter.string(from: date)
        }
        return "01 January 1970"
    }

}
