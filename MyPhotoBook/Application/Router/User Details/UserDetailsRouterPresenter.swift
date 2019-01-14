import UIKit

protocol UserDetailsRouterPresenterProtocol {
    func showUserDetails(for model: UserModel)
}

/// Presenter class for image details router.
class UserDetailsRouterPresenter: UserDetailsRouterPresenterProtocol {
    
    /// Function to show user details view.
    ///
    /// - Parameter model: user data model
    func showUserDetails(for model: UserModel) {
        self.router?.showUserDetails(for: model)
    }
    
    var router: UserDetailsRouterProtocol?
    
    /// Initializer
    ///
    /// - Parameter router: user details router protocol.
    init(router: UserDetailsRouterProtocol) {
        self.router = router
    }
}
