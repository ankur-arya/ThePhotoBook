import UIKit
import RxSwift

/// Implementer class for User Details List.
class UserDetailsImpl: UserDetailsPresenter {
    var userRepo: UserRepo
    
    init(repo: UserRepo) {
        self.userRepo = repo
    }
    
    /// Fetch user details
    ///
    /// - Parameters:
    ///   - params: API parameters.
    ///   - username: username
    /// - Returns: RxSwift Observable of UserModel.
    func fetchUser(params: [String: String]?, username: String) -> Observable<UserModel> {
        let intractor = FetchUserImpl(repo: self.userRepo)
        let user = intractor.fetchUser(params: params, username: username).map { (user) -> UserModel in
            return ModelsConverter().convertUserToUserModel(user: user)
        }
        return user
    }
}
