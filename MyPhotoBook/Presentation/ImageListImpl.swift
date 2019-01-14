import UIKit
import RxSwift

/// Implementer class for  Image List.
class ImageListImpl: ImageListPresenter {
    var imageRepo: ImageRepo
    
    init(repo: ImageRepo) {
        self.imageRepo = repo
    }
    
    /// Fetch Images.
    ///
    /// - Parameter params: API parameters
    /// - Returns: RxSwift Observable of ImageModel array.
    func fetchImages(params: [String: String]?) -> Observable<[ImageModel]> {
        let intractor = FetchImagesImpl(repo: self.imageRepo)
        let images = intractor.fetchImages(params: params).map { (images) -> [ImageModel] in
            return images.map({ModelsConverter().convertImageToImageModel(image: $0)})
        }
        return images
    }
}
