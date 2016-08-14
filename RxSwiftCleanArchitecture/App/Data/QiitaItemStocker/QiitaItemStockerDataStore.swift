//
//  QiitaItemStockerDataStore.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/07.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

import RxSwift
import Foundation

class QiitaItemStockerDataStore : NSObject {

    let request = QiitaItemStockerRequest()
    
    func fetch(params params : [String : AnyObject], retryCount : Int) -> Observable<QiitaItemStockerEntities> {
        return request.fetch(params: params, retryCount: retryCount)
    }
}
