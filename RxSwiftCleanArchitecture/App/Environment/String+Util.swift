//
//  String+Util.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/12.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

import Foundation

extension String {
    
    func transformNSDateGmt()  -> NSDate? {
        let df = NSDateFormatter()
        df.locale = NSLocale(localeIdentifier : "ja_JP")
        df.timeZone = NSTimeZone(name : "JST")
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:sszzz"
        return df.dateFromString(self)
    }
}