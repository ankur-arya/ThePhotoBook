import UIKit

/// Image Details Class
class ImageDetailsViewController: BaseViewController {
    @IBOutlet weak var photographView: UIImageView?
    @IBOutlet weak var location: UILabel?
    @IBOutlet weak var userName: UILabel?
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var userImage: UIImageView?
    @IBOutlet weak var caption: UILabel?
    @IBOutlet weak var likes: UILabel?
    
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
        likes?.text = imageDetails?.likes
        location?.text = imageDetails?.user.location
        userName?.text = imageDetails?.user.username
        loader = Loader(view: photographView, style: .whiteLarge)
        setImage(url: imageDetails?.user.profileImage, view: userImage)
        setImage(url: imageDetails?.photographLarge, view: photographView)
        userImage?.layer.cornerRadius = 50
        userImage?.clipsToBounds = true
        caption?.text = imageDetails?.caption
        photographView?.isUserInteractionEnabled = true
        photographView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ImageDetailsViewController.fullScreen)))
    }
    
    @objc func fullScreen() {
        if let image = imageDetails {
            let router = FullImagesRouter(viewController: self)
            let presenter = FullImagesRouterPresenter(router: router, index: IndexPath(row: 0, section: 0))
            presenter.showFullImages(for: [image], index: IndexPath(row: 0, section: 0))
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
    }
    
    /// Get Image from URL and set to image view.
    ///
    /// - Parameters:
    ///   - url: url
    ///   - view: image view on which image needs to be set.
    private func setImage(url: URL?, view: UIImageView?) {
        loader?.start()
        view?.image = nil
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
