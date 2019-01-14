import UIKit
import RxSwift

/// Interface for Image repo.
protocol ImageRepo {
    
    /// Fetch Images.
    ///
    /// - Parameter params: API parameters
    /// - Returns: RxSwift Observable of Image array.
    func fetchImages(params: [String: String]?) -> Observable<[Image]>
}
