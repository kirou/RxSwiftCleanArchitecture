//
//  QiitaItemStockerRepository.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/07.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

import RxSwift

protocol QiitaItemStockerRepositoryProtocol {
    func fetch(params params : [String : AnyObject], retryCount : Int) -> Observable<QiitaItemStockerEntities>
}

class QiitaItemStockerRepository : QiitaItemStockerRepositoryProtocol {
    
    lazy var dataStore = QiitaItemStockerDataStore()
    
    func fetch(params params: [String : AnyObject], retryCount: Int) -> Observable<QiitaItemStockerEntities> {
        
        return dataStore.fetch(params : params, retryCount : retryCount)
            .catchError { error in
                // API Requestでthrowされた時のcatch先
                // ここでは空のオブジェクトを入れるようにする
                return Observable.just(QiitaItemStockerEntities())
        }
    }
}
