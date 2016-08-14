//
//  ListUseCase.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/11.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

/**
 *
 * 各Scenesで利用するビジネスロジックをここに集約 & EntityなどをPresentaion層用の型を変換する。
 * 基本的にreturnはObservable型ので、宣言が集約した場所です
 * Observableにしておくと、Presenterのところで加工や合成、並列で取得など操作がスマートです
 *
 * Rxじゃない場合は、delegateやcallbackでoutput portを用意してreturnなしにしています。
 * RxでもListPresneterのようにSubjectにしてreturnなしで通知する方法がありますが
 * Observableでretrunする方がシンプルな気がしているので、ここではObservableでreturnしています。
 * (レイヤーをまたぐ場合について、Clean ArchitecureやRxに詳しい人から意見がほしいな～と思っています)
 *
 * Repository経由でデータを取得し、Presentationで利用する型を生成する
 * また、依存度注入し疎結合にしておくと素敵です。
 * 疎結合になることによって、Protocolを利用しているテストクラスを用いてテストがしやすくなります。
 *
 */

import Foundation
import RxSwift

protocol ListUseCaseProtocol : class {
    func loadData() -> Observable<ListModels>
}

class ListUseCase : ListUseCaseProtocol {
    
    var qiitaItemRepository : QiitaItemRepositoryProtocol!
    
    init (qiitaItemRepository : QiitaItemRepositoryProtocol) {
        self.qiitaItemRepository = qiitaItemRepository
    }
    
    deinit {
    }
}

extension ListUseCase {
    
    func loadData() -> Observable<ListModels> {
        
        return qiitaItemRepository.fetch(params : [:], retryCount: 3)
            .subscribeOn(Dependencies.sharedInstance.backgroundScheduler)
            .flatMap { qiitaItem -> Observable<ListModels> in
                return Observable.just(ListTranslater.generate(qiitaItems : qiitaItem))
            }
            .observeOn(Dependencies.sharedInstance.mainScheduler)
            .shareReplay(1)
    }
}