import UIKit
import RxSwift

/// Interface for User repo.
protocol UserRepo {
    /// Fetch user details
    ///
    /// - Parameters:
    ///   - params: API parameters.
    ///   - username: username
    /// - Returns: RxSwift Observable of User.
    func fetchUser(params: [String: String]?, username: String) -> Observable<User>
}
