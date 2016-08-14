//
//  ApiClient.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/07.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

import Alamofire
import RxSwift
import RxCocoa

class ApiClient {
    
    private let manager = Alamofire.Manager.sharedInstance
    
    static let sharedInstance = ApiClient()
    
    private init() { }
    
    func request(method method : Alamofire.Method, url : String, params : [String : AnyObject]) -> Observable<(NSData, NSHTTPURLResponse)> {
        
        var mutableRequest = NSMutableURLRequest(URL : NSURL(string : url)!)
        mutableRequest.cachePolicy = .ReloadIgnoringLocalCacheData
        mutableRequest.timeoutInterval = 10
        mutableRequest.HTTPMethod = method.rawValue
        mutableRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        mutableRequest = Alamofire.ParameterEncoding.URL.encode(mutableRequest, parameters: params).0
        
        return manager.session.rx_response(mutableRequest)
    }
}
