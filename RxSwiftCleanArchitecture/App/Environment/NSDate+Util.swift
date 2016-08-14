//
//  NSDate+Util.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/12.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

import Foundation

extension NSDate {
    
    func transformToString(format : String = "") -> String {
        
        let df : NSDateFormatter = NSDateFormatter()
        df.locale   = NSLocale(localeIdentifier : "ja_JP")
        df.timeZone = NSTimeZone(name : "JST")
        
        if format == "" {
            df.dateFormat = "yyyy-MM-dd'T'HH:mm:sszzz"
        } else {
            df.dateFormat = format
        }
        return df.stringFromDate(self)
    }
    
}