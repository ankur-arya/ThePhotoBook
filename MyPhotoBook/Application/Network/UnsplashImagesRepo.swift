import UIKit
import RxSwift

/// Network Image Repo
class UnsplashImagesRepo: ImageRepo {
    
    /// Fetch Image from Server.
    ///
    /// - Parameter params: API parameters.
    /// - Returns: RxSwift Observable of Image array.
    func fetchImages(params: [String: String]?) -> Observable<[Image]> {
        return Observable.create({ observer in
            FetchImagesFromServer(params:params).execute(onSuccess: { (unsplashImage) in
            let data = unsplashImage.map({ModelsConverter().convertUnsplashToImage(from:$0)})
            observer.onNext(data)
            }, onError: { (error) in
                observer.onError(error)
            })
            return Disposables.create {
            }
        })
    }
}
