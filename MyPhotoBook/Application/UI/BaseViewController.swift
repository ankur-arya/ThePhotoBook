import UIKit
import QuartzCore


/// Base class for all view controllers in My Photo Book.
class BaseViewController: UIViewController, CAAnimationDelegate {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.viewBackground
        setUpNavigationBar()
    }

    /// Setting up custom navigation bar with title image and color.
    private func setUpNavigationBar() {
        self.title = "My Photo Book"
        navigationController?.navigationBar.barTintColor = AppColors.navigationBar
//        navigationController?.navigationBar.isTranslucent = type(of: self) == type(of: FeedViewController.self)
    }

    /// To show alert on view controller if an api throws an error.
    ///
    /// - Parameter error: error object from network call.
    internal func showError(with error: Error) {
        let alert = UIAlertController(title: "Error!!!", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
