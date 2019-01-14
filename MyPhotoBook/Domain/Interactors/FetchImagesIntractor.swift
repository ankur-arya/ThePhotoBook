import UIKit
import RxSwift

protocol FetchImagesIntractor {
    /// Fetch Images.
    ///
    /// - Parameter params: API parameters
    /// - Returns: RxSwift Observable of Image array.
    func fetchImages(params: [String: String]?) -> Observable<[Image]>
}
