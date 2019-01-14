import UIKit
import RxSwift

/// Interface for User Details.
protocol UserDetailsPresenter {
    
    /// Fetch user details
    ///
    /// - Parameters:
    ///   - params: API parameters.
    ///   - username: username
    /// - Returns: RxSwift Observable of UserModel.
    func fetchUser(params: [String: String]?, username: String) -> Observable<UserModel>
}
