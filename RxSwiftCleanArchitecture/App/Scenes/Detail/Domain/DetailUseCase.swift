//
//  DetailUseCase.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/11.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol DetailUseCaseProtocol : class {
    //func loadData(itemId itemdId : String) -> Observable<DetailModelsList>
}

class DetailUseCase : DetailUseCaseProtocol {
    
    var qiitaItemStockerRepository : QiitaItemStockerRepositoryProtocol!
    var qiitaItemCommentRepository : QiitaItemCommentRepositoryProtocol!
    
    init (qiitaItemStockerRepository : QiitaItemStockerRepositoryProtocol,
        qiitaItemCommentRepository : QiitaItemCommentRepositoryProtocol) {
        self.qiitaItemStockerRepository = qiitaItemStockerRepository
        self.qiitaItemCommentRepository = qiitaItemCommentRepository
    }
    
    deinit {
    }
}

extension DetailUseCase {
    
    /**
     * Observable.zipやcombineLatestを利用すると並列処理っぽくできてハッピーです
     */
    /*
    func loadData(itemId itemId : String) -> Observable<DetailModelsList> {
        
        return Observable.zip(
            qiitaItemStockerRepository.fetch(params: ["itemId" : itemId], retryCount: 3),
            qiitaItemCommentRepository.fetch(params: ["itemId" : itemId], retryCount: 3)
        ) { stocker, comment in
            return (stocker, comment)
            }
            .subscribeOn(Dependencies.sharedInstance.backgroundScheduler)
            .flatMap { stocker, comment -> Observable<DetailModelsList> in
                return Observable.just(DetailTranslater.generate(
                    qiitaCommentItems : comment,
                    qiitaStockerItems : stocker
                    )
                )
            }
            .observeOn(Dependencies.sharedInstance.mainScheduler)
            .shareReplay(1)
    }
 */
}
