import UIKit
import RxSwift

class FeedViewController: BaseViewController {
    
    @IBOutlet weak var feedTableView: UITableView?
    
    let zoomImageView = UIImageView()
    let blackBackgroundView = UIView()
    let navBarCoverView = UIView()
    var statusImageView: UIImageView?
    var currentPage = 1
    var loader: Loader?
    let cellIdentifier = "FeedTableViewCell"
    var images: [ImageModel]?
    var lastContentOffset: CGFloat = 0.0
    var isScrollingUp: Bool = false
    var imageListPresenter: ImageListPresenter?
    let disposeBag = CompositeDisposable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTableView?.tableFooterView = UIView()
        loader = Loader(view: self.view, style: .whiteLarge)
        fetchFeed("1")
    }
    
    /// Fetch Image Feed from API.
    ///
    /// - Parameter page: page number for image feed.
    fileprivate func fetchFeed(_ page: String) {
        loader?.start()
        let params = ["per_page": "30",
                      "page": page, "orientation": "landscape"]
        
        let imageRepo: ImageRepo = UnsplashImagesRepo()
        imageListPresenter = ImageListImpl(repo: imageRepo)
        let myBusyScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
        if let disposable = imageListPresenter?.fetchImages(params:params)
            .subscribeOn(myBusyScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (images) in
            if (self.images != nil) {
                self.images?.append(contentsOf: images)
            } else {
                self.images = images
            }
            self.loader?.stop()
            self.feedTableView?.reloadData()
        }, onError: { (error) in
            self.showError(with: error)
            self.loader?.stop()
        }) {
            let _ = disposeBag.insert(disposable)
        }
    }
    
    /// Push to user details.
    ///
    /// - Parameter user: user model.
    func pushToUserDetails(user: UserModel) {
        let router = UserDetailsRouter(viewController: self)
        let presenter = UserDetailsRouterPresenter(router: router)
        presenter.showUserDetails(for: user)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        disposeBag.dispose()
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? FeedTableViewCell {
            if let image = images?[indexPath.row] {
                cell.setData(image: image)
                cell.feedViewController = self
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let image = images?[indexPath.row] {
            let router = ImageDetailsRouter(viewController: self)
            let presenter = ImageDetailsRouterPresenter(router: router)
            presenter.showImageDetails(for: image)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let direction: CGFloat = isScrollingUp ? -200 : 200
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, direction, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.45) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        isScrollingUp = self.lastContentOffset > scrollView.contentOffset.y
        self.lastContentOffset = scrollView.contentOffset.y;
    }

}

// MARK: - Image Animations
extension FeedViewController {
    
    func animateImageView(_ statusImageView: UIImageView) {
        self.statusImageView = statusImageView
        
        if let startingFrame = statusImageView.superview?.convert(statusImageView.frame, to: nil) {
            statusImageView.alpha = 0

            blackBackgroundView.frame = self.view.frame
            blackBackgroundView.backgroundColor = UIColor.black
            blackBackgroundView.alpha = 0
            view.addSubview(blackBackgroundView)
            
            navBarCoverView.frame = CGRect(x: 0, y: 0, width: 1000, height: 20 + 44)
            navBarCoverView.backgroundColor = UIColor.black
            navBarCoverView.alpha = 0
   
            if let keyWindow = UIApplication.shared.keyWindow {
                keyWindow.addSubview(navBarCoverView)
            }
            
            zoomImageView.backgroundColor = UIColor.black
            zoomImageView.frame = startingFrame
            zoomImageView.isUserInteractionEnabled = true
            zoomImageView.image = statusImageView.image
            zoomImageView.contentMode = .scaleAspectFill
            zoomImageView.clipsToBounds = true
            view.addSubview(zoomImageView)
            
            zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FeedViewController.zoomOut)))
            blackBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FeedViewController.zoomOut)))
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: { () -> Void in
                
                let height = (self.view.frame.width / startingFrame.width) * startingFrame.height * 2
                
                let y = self.view.frame.height / 2 - height / 2
                
                self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
                
                self.blackBackgroundView.alpha = 1
                
                self.navBarCoverView.alpha = 1
                
            }, completion: nil)
            
        }
    }
    
    @objc func zoomOut() {
        if let startingFrame = statusImageView?.superview?.convert(statusImageView?.frame ?? CGRect.zero, to: nil) {
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.zoomImageView.frame = startingFrame
                self.blackBackgroundView.alpha = 0
                self.navBarCoverView.alpha = 0
                
            }, completion: { (didComplete) -> Void in
                self.zoomImageView.removeFromSuperview()
                self.blackBackgroundView.removeFromSuperview()
                self.navBarCoverView.removeFromSuperview()
                self.statusImageView?.alpha = 1
            })
        }
    }
}
