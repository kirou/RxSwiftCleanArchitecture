//
//  ErrorHandring.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/08.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

import Foundation

struct ErrorHandring {
    
    enum Request : ErrorType {
        case InvalidParameter
        case ParseError
        case EmptyData
        
        func createMessageNSError(title title : String, message : String, code : String) -> ErrorType {
            return ErrorHandring.createNSError(title: title, message: message, code: code)
        }
    }
    
    static func createNSError(title title : String, message : String, code : String) -> ErrorType {
        let userInfo = createUserInfo(title : title, message: message, code: code)
        return NSError(domain: code, code : Int(code)!, userInfo: userInfo)
    }
    
    static func createUserInfo(title title : String, message : String, code : String) -> [String : String] {
        return [
            NSLocalizedDescriptionKey : title,
            NSLocalizedFailureReasonErrorKey : message,
            NSLocalizedRecoverySuggestionErrorKey : code
        ]
    }
}