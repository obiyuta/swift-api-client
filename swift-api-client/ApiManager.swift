//
//  ApiManager.swift
//  swift-api-client
//
//  Created by obiyuta on 2016/03/20.
//  Copyright © 2016 obiyuta. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import ObjectMapper

// About "ResultResult" : http://qiita.com/obi_yuta/items/ad386ba7b71c5102f1c3
typealias ApiResult = ResultResult<Mappable, ApiError>.t


// MARK: - ApiError

enum ApiError : ErrorType {
    case NotFound
    case ParseFailed
    case TypeMismatch
    case RequestFailed
    case InvalidResult
}


// MARK: - Requestable

protocol Requestable: URLRequestConvertible {
    typealias ResponseType
    var method: Alamofire.Method { get }
    var path: String { get }
    var parameters: [String: AnyObject] { get set }
    var encoding: ParameterEncoding { get }
    var headers: [String: String]? { get }
}

extension Requestable {

    var method: Alamofire.Method {
        return .GET
    }
    var encoding: ParameterEncoding {
        return .URL
    }
    var headers: [String: String]? {
        return nil
    }

    var URLRequest: NSMutableURLRequest {

        let baseUrl = NSURL(string: "https://api.stackexchange.com/2.2/")!
        let url = baseUrl.URLByAppendingPathComponent(path)

        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = method.rawValue
        request.allHTTPHeaderFields = headers

        var params = parameters
        params["site"] = "stackoverflow"
        
        request = encoding.encode(request, parameters: params).0
        
        return request;
    }

}

extension Requestable where ResponseType: Mappable {
    
    func fromResponse(json: AnyObject) -> ApiResult {
        guard let result: ResponseType = Mapper<ResponseType>().map(json)! else {
            return .Failure(ApiError.TypeMismatch)
        }
        return .Success(result)
    }
    
}


// MARK: - ApiManager

class ApiManager {
    
    class func call<T: Requestable where T.ResponseType: Mappable>(request: T) -> Observable<T.ResponseType> {
        
        return Observable.create { (observer: AnyObserver<T.ResponseType>) -> Disposable in
            let task = Alamofire.request(request).responseJSON(options:.AllowFragments) { response in
                switch response.result {
                case .Success:
                    guard let data = response.result.value else {
                        observer.onError(ApiError.TypeMismatch)
                        return
                    }

                    let result = request.fromResponse(data)

                    switch result {
                    case .Success(let value):
                        guard let value = value as? T.ResponseType else {
                            observer.onError(ApiError.TypeMismatch)
                            break
                        }
                        observer.onNext(value)
                        observer.onCompleted()
                    case .Failure:
                        observer.onError(ApiError.RequestFailed)
                    }
                case .Failure:
                    observer.onError(ApiError.InvalidResult)
                }
            }
            
            let t = task
            t.resume()
            
            return AnonymousDisposable {
                task.cancel()
            }
            
        }
        
    }

}

