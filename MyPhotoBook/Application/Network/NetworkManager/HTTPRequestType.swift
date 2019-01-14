import UIKit

/// HTTPRequestType interface.
internal protocol HTTPRequestType {
    associatedtype HTTPResponseType: Codable
    var data: HTTPRequestData { get }
}

extension HTTPRequestType {
    
    /// Execution of network requests.
    ///
    /// - Parameters:
    ///   - dispatcher: network dispatcher with request data.
    ///   - onSuccess: complition block for success.
    ///   - onError: complition block for error.
    internal func execute (
        dispatcher: NetworkDispatcher = URLSessionNetworkDispatcher.instance,
        onSuccess: @escaping (HTTPResponseType) -> Void,
        onError: @escaping (Error) -> Void
        ) {
        dispatcher.dispatch(
            request: self.data,
            onSuccess: { (responseData: Data) in
                do {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    let result = try jsonDecoder.decode(HTTPResponseType.self, from: responseData)
                    DispatchQueue.main.async {
                        onSuccess(result)
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        onError(error)
                    }
                }
        },
            onError: { (error: Error) in
                DispatchQueue.main.async {
                    onError(error)
                }
        }
        )
    }
}


internal protocol HTTPDataRequestType {
    var data: HTTPRequestData { get }
}


extension HTTPDataRequestType {
    
    /// Download Image from network.
    ///
    /// - Parameters:
    ///   - dispatcher: network dispatcher with request data.
    ///   - onSuccess: complition block for success.
    ///   - onError: complition block for error.
    internal func downloadImage(dispatcher: NetworkDispatcher = URLSessionNetworkDispatcher.instance,
                                onSuccess: @escaping (UIImage) -> Void,
                                onError: @escaping (Error) -> Void) {
        dispatcher.dispatch(
            request: self.data,
            onSuccess: { (responseData: Data) in
                DispatchQueue.main.async {
                    if let result = UIImage(data: responseData) {
                        onSuccess(result)
                    } else {
                        let error = NSError(domain:"Invalid Image Data", code:-1001, userInfo:nil)
                        onError(error)
                    }
                }
        },
            onError: { (error: Error) in
                DispatchQueue.main.async {
                    onError(error)
                }
        }
        )
    }
}
