import UIKit
import RxSwift

protocol FetchUserIntractor {
    /// Fetch user details
    ///
    /// - Parameters:
    ///   - params: API parameters.
    ///   - username: username
    /// - Returns: RxSwift Observable of User.
    func fetchUser(params: [String: String]?, username: String) -> Observable<User>
}
