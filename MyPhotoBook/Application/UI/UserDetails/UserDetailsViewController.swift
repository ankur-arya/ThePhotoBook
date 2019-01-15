import UIKit
import RxSwift

/// User Details Class
class UserDetailsViewController: BaseViewController {
    var user: UserModel?
    
    @IBOutlet weak var userView: UIView?
    @IBOutlet weak var imageCollection: UICollectionView?
    @IBOutlet weak var bio: UILabel?
    @IBOutlet weak var totalLikes: UILabel?
    @IBOutlet weak var totalPhotos: UILabel?
    @IBOutlet weak var userName: UILabel?
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var userImage: UIImageView?
    var lastContentOffset: CGFloat = 0.0
    var isScrollingUp: Bool = false
    var userDetailsPresenter: UserDetailsPresenter?
    let disposeBag = CompositeDisposable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = user?.name
        if let userName = user?.username {
            fetchUserDetails(username: userName)
        }
    }
    
    private func setupView() {
        bio?.text = user?.bio
        totalPhotos?.text = (user?.totalPhotos ?? "") + " Photos"
        totalLikes?.text = (user?.totalLikes ?? "") + " Likes"
        userName?.text = user?.username
        name?.text = user?.name
        setImage(url: user?.profileImage, view: userImage)
        if let width = userImage?.frame.size.width {
            userImage?.layer.cornerRadius = width / 2
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
        self.setupView()
    }
    
    /// Get Image from URL and set to image view.
    ///
    /// - Parameters:
    ///   - url: url
    ///   - view: image view on which image needs to be set.
    private func setImage(url: URL?, view: UIImageView?) {
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

    
    /// Fetch user details from API.
    ///
    /// - Parameter username: username for which details need to be fetched.
    private func fetchUserDetails(username: String) {
        let params = ["per_page": "50"]
        let userRepo: UserRepo = UnsplashUserRepo()
        userDetailsPresenter = UserDetailsImpl(repo: userRepo)
        let myBusyScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
        
        if let disposable = userDetailsPresenter?.fetchUser(params:params, username: username)
            .subscribeOn(myBusyScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (user) in
            self.user?.images = user.images
            self.imageCollection?.reloadData()
        }, onError: { (error) in
            self.showError(with: error)
        }) {
            let _ = disposeBag.insert(disposable)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        disposeBag.dispose()
    }
}

// MARK: - Extension for CollectionView
extension UserDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user?.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell {
            if let image = user?.images?[indexPath.item] {
                cell.setData(image: image)
            }
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width / 2) - 13, height: (self.view.frame.width / 2) - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let direction: CGFloat = isScrollingUp ? -100 : 100
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, direction, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0.5
        UIView.animate(withDuration: 1.0) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        isScrollingUp = self.lastContentOffset > scrollView.contentOffset.y
        self.lastContentOffset = scrollView.contentOffset.y;
    }
}
