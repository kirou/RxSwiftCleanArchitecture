//
//  QiitaItemDataStore.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/07.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

import RxSwift
import Foundation

class QiitaItemDataStore : NSObject {

    let request = QiitaItemRequest()
    
    func fetch(params params : [String : AnyObject], retryCount : Int) -> Observable<QiitaItemEntities> {
        return request.fetch(params: params, retryCount: retryCount)
    }
}