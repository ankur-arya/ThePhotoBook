import UIKit
import RxSwift


/// Network User Repo.
class UnsplashUserRepo: UserRepo {
    /// Fetch User Details from Server.
    ///
    /// - Parameters:
    ///   - params: API parameters.
    ///   - username: user name for which details are fetched.
    /// - Returns: RxSwift Observable of User array.
    func fetchUser(params: [String : String]?, username: String) -> Observable<User> {
        return Observable.create({ observer in
            FetchUserFromServer(params:params, username: username).execute(onSuccess: { (user) in
                if let data = ModelsConverter().convertUnsplashToUserModel(from:user) {
                    observer.onNext(data)
                } else {
                    observer.onError(RxError.noElements)
                }
            }, onError: { (error) in
                observer.onError(error)
            })
            return Disposables.create {}
        })
    }
}
