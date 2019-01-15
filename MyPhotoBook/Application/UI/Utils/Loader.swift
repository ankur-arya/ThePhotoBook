import UIKit

class Loader {
    var activityIndicator: UIActivityIndicatorView?
    var parentView: UIView?
    
    /// Initializer
    ///
    /// - Parameters:
    ///   - view: view on which loader needs to be displayed.
    ///   - style: loader style.
    init(view: UIView?, style: UIActivityIndicatorView.Style) {
        parentView = view
        activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator?.center = parentView?.center ?? CGPoint.zero
        activityIndicator?.color = UIColor.black
    }
    
    /// To start showing loader.
    func start() {
        activityIndicator?.startAnimating()
        parentView?.addSubview(activityIndicator!)
    }
    
    /// To stop showing loader.
    func stop() {
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
    }
}
