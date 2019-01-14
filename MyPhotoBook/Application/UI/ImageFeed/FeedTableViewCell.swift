import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var photograph: UIImageView?
    @IBOutlet weak var userImage: UIImageView?
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var date: UILabel?
    
    var imageModel: ImageModel?
    var feedViewController: FeedViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @objc func animateImage() {
        feedViewController?.animateImageView(photograph ?? UIImageView())
    }
    
    @objc func showUserDetails() {
        if let user = imageModel?.user {
            feedViewController?.pushToUserDetails(user: user)
        }
    }
    
    internal func setData(image: ImageModel) {
        imageModel = image
        setupUserImage()
        setupPhotograph()
        date?.text = image.date
        name?.text = image.user.name
        name?.isUserInteractionEnabled = true
        name?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FeedTableViewCell.showUserDetails)))
    }
    
    func setupPhotograph() {
        photograph?.isUserInteractionEnabled = true
        photograph?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FeedTableViewCell.animateImage)))
        setImage(url: imageModel?.photograph, view: photograph)
    }
    
    func setupUserImage() {
        userImage?.layer.cornerRadius = 25
        userImage?.clipsToBounds = true
        userImage?.isUserInteractionEnabled = true
        userImage?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FeedTableViewCell.showUserDetails)))
        setImage(url: imageModel?.user.profileImage, view: userImage)
    }
    
    /// Get Image from URL and set to image view.
    ///
    /// - Parameters:
    ///   - url: url
    ///   - view: image view on which image needs to be set.
    func setImage(url: URL?, view: UIImageView?) {
        view?.image = nil
        guard let imageUrl = url else {
            view?.image = UIImage(named: "PlaceHolderImage")
            return
        }
        FetchImageFromURL(url: imageUrl.absoluteString).downloadImage(onSuccess: { (image) in
            DispatchQueue.main.async {
                view?.image = image
            }
        }) { (error) in
            DispatchQueue.main.async {
                view?.image = UIImage(named: "PlaceHolderImage")
            }
        }
    }
}
