//
//  QiitaItemCommentRepository.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/07.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

import RxSwift

protocol QiitaItemCommentRepositoryProtocol {
    func fetch(params params : [String : AnyObject], retryCount : Int) -> Observable<QiitaItemCommentEntities>
}

class QiitaItemCommentRepository : QiitaItemCommentRepositoryProtocol {
    
    lazy var dataStore = QiitaItemCommentDataStore()
    
    func fetch(params params: [String : AnyObject], retryCount: Int) -> Observable<QiitaItemCommentEntities> {
        
        return dataStore.fetch(params : params, retryCount : retryCount)
            .catchError { error in
                // API Requestでthrowされた時のcatch先
                // ここでは空のオブジェクトを入れるようにする
                return Observable.just(QiitaItemCommentEntities())
        }
    }
}
