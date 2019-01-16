import UIKit

/// Collection view cell class to display images on User Details view.
class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView?
    var loader: Loader?
    func setData(image: ImageModel) {
        loader = Loader(view: self, style: .white)
        setImage(url: image.photograph, view: imageView)
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
            return
        }
        FetchImageFromURL(url: imageUrl.absoluteString).downloadImage(onSuccess: { (image) in
            DispatchQueue.main.async {
                view?.image = image
                self.loader?.stop()
            }
        }) { (error) in
            DispatchQueue.main.async {
                self.loader?.stop()
                view?.image = UIImage(named: "PlaceHolderImage")
            }
        }
    }
}
