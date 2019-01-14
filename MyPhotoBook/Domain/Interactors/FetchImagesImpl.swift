import UIKit
import RxSwift

class FetchImagesImpl: FetchImagesIntractor {
    var imageRepo: ImageRepo
    
    init(repo: ImageRepo) {
        self.imageRepo = repo
    }
    /// Fetch Images.
    ///
    /// - Parameter params: API parameters
    /// - Returns: RxSwift Observable of Image array.
    func fetchImages(params: [String: String]?) -> Observable<[Image]> {
        // Do aditional computation
        return imageRepo.fetchImages(params: params)
    }

}
