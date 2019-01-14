import UIKit
import RxSwift

class FetchUserImpl: FetchUserIntractor {
    var userRepo: UserRepo
    
    init(repo: UserRepo) {
        self.userRepo = repo
    }
    
    /// Fetch user details
    ///
    /// - Parameters:
    ///   - params: API parameters.
    ///   - username: username
    /// - Returns: RxSwift Observable of User.
    func fetchUser(params: [String: String]?, username: String) -> Observable<User> {
        // Do aditional computation
        return userRepo.fetchUser(params: params, username: username)
    }
    
}
