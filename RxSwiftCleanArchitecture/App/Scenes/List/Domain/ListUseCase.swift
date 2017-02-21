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
 *  (disposeBagに入れるところは極力まとまっていた方がいいです)
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
    
    private let qiitaItemRepository : QiitaItemRepositoryProtocol!
    
    init (qiitaItemRepository : QiitaItemRepositoryProtocol) {
        self.qiitaItemRepository = qiitaItemRepository
    }
    
    deinit {
    }
}

extension ListUseCase {
    
    func loadData() -> Observable<ListModels> {
        
        return qiitaItemRepository.fetch(params : [:], retryCount: 3)
            .map { ListTranslater.generate(qiitaItems : $0) }
            .map { [unowned self] in self.updateContentsModel(models : $0) }
    }
}

private extension ListUseCase {
    
    func updateContentsModel(models models : ListModels) -> ListModels {
        
        models.contentsList.forEach { [unowned self] model -> () in
            self.createViewModel(model : model)
        }
        return models
    }
    
    func createViewModel(model model : ListModel) -> ListModel {
        
        let thumbnailUrl = NSURL(string : model.valueObject.userImage)
        let title  = model.valueObject.title
        let tags   = "タグ : " + model.valueObject.tags.joinWithSeparator(",")
        let body   = model.valueObject.body
        let userId = model.valueObject.userId
        
        if let date = model.valueObject.updatedAt.transformNSDateGmt() {
            let dateString = date.transformToString("yyyy年MM月dd日") + " 更新"
            model.viewModel.viewUpdatedAt = dateString
        }
        
        model.viewModel.viewThumbnail   = thumbnailUrl
        model.viewModel.viewIdWithTitle = title
        model.viewModel.viewTags        = tags
        model.viewModel.viewBody        = body
        model.viewModel.viewUserId      = userId
        
        return model
    }
}
