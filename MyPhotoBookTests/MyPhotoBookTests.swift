import XCTest
import RxSwift

@testable import MyPhotoBook

class MyPhotoBookTests: XCTestCase {
    let converter = ModelsConverter()
    let disposeBag = CompositeDisposable()
    
    let imageUrl = "https://images.all-free-download.com/images/graphiclarge/harry_potter_icon_6825007.jpg"
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        disposeBag.dispose()
    }
    
    func testConvertImageToImageModel() {
        let imageModel = converter.convertImageToImageModel(image: image)
        XCTAssertEqual(image.user.name, imageModel.user.name)
        XCTAssertEqual(imageModel.date, "January. 5. 2018")
    }
    
    func testConvertUserToUserModel() {
        let userModel = converter.convertUserToUserModel(user: user)
        XCTAssertEqual(user.name, userModel.name)
    }
    
    func testConvertUnsplashToImage() {
        let image = converter.convertUnsplashToImage(from: unsplash)
        XCTAssertEqual(image.caption, unsplash.caption)
    }
    
    func testConvertUnsplashToUserModel() {
        let userModel = converter.convertUnsplashToUserModel(from: [unsplash])
        XCTAssertEqual(userModel?.images?.first?.photograph, unsplash.urls.full)
    }

    func testFetchImagesIntractorWithNetworkRepo() {
        let ex = expectation(description: "photos")
        let myBusyScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
        let fetchImagesIntractor = FetchImagesImpl(repo: UnsplashImagesRepo())
        let disposable = fetchImagesIntractor.fetchImages(params: nil).subscribeOn(myBusyScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (images) in
                ex.fulfill()
                XCTAssertNotNil(images)
            }, onError: { (error) in
                ex.fulfill()
                XCTFail("Error: \(error.localizedDescription)")
            })
        
        let _ = disposeBag.insert(disposable)
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
    func testFetchUserIntractorWithNetworkRepo() {
        let ex = expectation(description: "photos")
        let myBusyScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
        let fetchUserIntractor = FetchUserImpl(repo: UnsplashUserRepo())
        let disposable = fetchUserIntractor.fetchUser(params: nil, username: "im4nkur").subscribeOn(myBusyScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (images) in
                ex.fulfill()
                XCTAssertNotNil(images)
            }, onError: { (error) in
                ex.fulfill()
                XCTFail("Error: \(error.localizedDescription)")
            })
        
        let _ = disposeBag.insert(disposable)
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
    var user: User {
        get {
            return User(id: "1", username: "im4nkur", name: "Ankur", bio: "I am a photographer.", location: "India", profileImage: nil, totalLikes: 3, totalPhotos: 5, images: nil)
        }
    }
    
    var image: Image {
        get {
            return Image(user: user, likes: "10", photograph: imageUrl, photographLarge: imageUrl, date: "2018-01-05T10:37:19-05:00", caption: "This is sample.")
        }
    }
    
    var unsplash: UnsplashData {
        get {
            return UnsplashData(id: "123", createdAt: "2018-01-05T10:37:19-05:00", width: 600, height: 600, color: "#ffffff", likes: 5, urls: imageUrls, user: userData, caption: "This is a caption.")
        }
    }
    
    var imageUrls: ImageUrls {
        get {
            return ImageUrls(raw: imageUrl, full: imageUrl, regular: imageUrl, small: imageUrl, thumb: imageUrl)
        }
    }
    
    var userData: UserData {
        get {
            return UserData(id: "123", username: "im4nkur", name: "Ankur Arya", bio: "I am a Photographer.", location: "India", profileImage: userImageUrls, totalLikes: 10, totalPhotos: 10)
        }
    }
    
    var userImageUrls: UserImageUrls {
        get {
            return UserImageUrls(small: imageUrl, medium: imageUrl, large: imageUrl)
        }
    }

}
