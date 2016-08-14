//
//  QiitaItemCommentDataStore.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/07.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

import RxSwift
import Foundation

class QiitaItemCommentDataStore : NSObject {

    let request = QiitaItemCommentRequest()
    
    func fetch(params params : [String : AnyObject], retryCount : Int) -> Observable<QiitaItemCommentEntities> {
        return request.fetch(params: params, retryCount: retryCount)
    }
}
