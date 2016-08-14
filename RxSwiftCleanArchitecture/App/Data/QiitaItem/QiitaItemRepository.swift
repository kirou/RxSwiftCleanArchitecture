//
//  QiitaItemRepository.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/07.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

import RxSwift

protocol QiitaItemRepositoryProtocol {
    func fetch(params params : [String : AnyObject], retryCount : Int) -> Observable<QiitaItemEntities>
}

class QiitaItemRepository : QiitaItemRepositoryProtocol {
    
    lazy var dataStore = QiitaItemDataStore()
    
    func fetch(params params: [String : AnyObject], retryCount: Int) -> Observable<QiitaItemEntities> {
        
        return dataStore.fetch(params : params, retryCount : retryCount)
            .catchError { error in
                // API Requestでthrowされた時のcatch先
                // ここでは空のオブジェクトを入れるようにする
                return Observable.just(QiitaItemEntities())
        }
    }
}