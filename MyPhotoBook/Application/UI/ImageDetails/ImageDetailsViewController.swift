import UIKit

/// Image Details Class
class ImageDetailsViewController: BaseViewController {
    @IBOutlet weak var photographView: UIImageView?
    @IBOutlet weak var location: UILabel?
    @IBOutlet weak var userName: UILabel?
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var userImage: UIImageView?
    @IBOutlet weak var caption: UILabel?
    var loader: Loader?
    var imageDetails: ImageModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @IBAction func userDetails(_ sender: Any) {
        if let user = imageDetails?.user {
            let router = UserDetailsRouter(viewController: self)
            let presenter = UserDetailsRouterPresenter(router: router)
            presenter.showUserDetails(for: user)
        }
    }
    
    func setupView() {
        name?.text = imageDetails?.user.name
        location?.text = imageDetails?.user.location
        userName?.text = imageDetails?.user.username
        setImage(url: imageDetails?.user.profileImage, view: userImage)
        setImage(url: imageDetails?.photographLarge, view: photographView)
        userImage?.layer.cornerRadius = 50
        userImage?.clipsToBounds = true
        caption?.text = imageDetails?.caption
        if let photoView = photographView {
            loader = Loader(view: photoView, style: .whiteLarge)
        }
        
    }
    
    /// Get Image from URL and set to image view.
    ///
    /// - Parameters:
    ///   - url: url
    ///   - view: image view on which image needs to be set.
    func setImage(url: URL?, view: UIImageView?) {
        view?.image = nil
        loader?.start()
        guard let imageUrl = url else {
            view?.image = UIImage(named: "PlaceHolderImage")
            loader?.stop()
            return
        }
        FetchImageFromURL(url: imageUrl.absoluteString).downloadImage(onSuccess: { (image) in
            DispatchQueue.main.async {
                view?.image = image
                self.loader?.stop()
            }
        }) { (error) in
            DispatchQueue.main.async {
                view?.image = UIImage(named: "PlaceHolderImage")
                self.loader?.stop()
            }
        }
    }

}
