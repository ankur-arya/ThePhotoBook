import UIKit
import RxSwift

/// Interface for Image List.
protocol ImageListPresenter {
    
    /// Fetch Images.
    ///
    /// - Parameter params: API parameters
    /// - Returns: RxSwift Observable of ImageModel array.
    func fetchImages(params: [String: String]?) -> Observable<[ImageModel]>
}
