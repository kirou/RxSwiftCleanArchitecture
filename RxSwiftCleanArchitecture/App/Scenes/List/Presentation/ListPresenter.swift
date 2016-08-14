//
//  ListPresenter.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/12.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

/**
 * ViewController側のアクションを受け取り、必要があればUseCaseにアクセスする。
 * UseCaseから取得したデータを加工し、ViewController/Viewの変更を通知する
 * (プレゼンテーションロジック)
 *
 * また、基本的に利用できる型はModelで定義したListModels or ListModelのみ
 * (そうすることで、取得するデータ先が変更になっても、PresenterやViewControllerを修正することがなくなっていきます)
 */


import Foundation
import RxSwift
import RxCocoa

protocol ListPresenterProtocol : class {
    
    // viewModel部分は作るものによってはObservableやSubjectにする場合もあると思いますが
    // 今回はそのままです
    var viewModels : ListModels {get}
    var viewReloadData : PublishSubject<Bool> {get}
    var viewErrorPage : PublishSubject<Bool> {get}
    var isStartActivityIndicator : PublishSubject<Bool> {get}
    
    func load()
}

class ListPresenter : ListPresenterProtocol {
    
    var useCase : ListUseCaseProtocol!
    
    // 公開
    private(set) var viewModels : ListModels = ListModels()
    private(set) var viewReloadData = PublishSubject<Bool>()
    private(set) var viewErrorPage  = PublishSubject<Bool>()
    private(set) var isStartActivityIndicator = PublishSubject<Bool>()
    
    // 非公開
    private let disposeBag = DisposeBag()
    
    init (useCase : ListUseCaseProtocol) {
        self.useCase = useCase
    }
    
    deinit {
    }
}

extension ListPresenter {
    
    func load() {
        
        Observable.just(true)
            .debug()
            .map { [unowned self] activityStatus in
                self.isStartActivityIndicator.onNext(activityStatus)
            }
            .debug()
            .flatMap { [unowned self] _ in
                return self.useCase.loadData()
            }
            .debug()
            .subscribe(
                // ストリームから流れたデータをViewModelsにセット
                onNext : { [weak self] models in
                    guard let weakSelf = self else { return }
                    weakSelf.viewModels.contentsList = weakSelf.createCellViewData(models : models)
                    weakSelf.viewReloadData.onNext(true)
                    weakSelf.isStartActivityIndicator.onNext(false)
                },
                // エラーが流れたらエラーページを表示
                onError : { [weak self] error in
                    guard let weakSelf = self else { return }
                    weakSelf.viewErrorPage.onNext(true)
                    weakSelf.isStartActivityIndicator.onNext(false)
                },
                // 完了時にはインジケータを隠す
                // (ちなみにonErrorに入るとonCompletedには流れません)
                onCompleted : { _ in
                }
            ).addDisposableTo(disposeBag)
    }
}


private extension ListPresenter {
    
    func createCellViewData(models models : ListModels) -> [ListModel] {
        
        return models.contentsList.map { [unowned self] model in
            return self.createCellData(data: model)
        }
    }
    
    func createCellData(data data : ListModel) -> ListModel {
        
        let thumbnailUrl = NSURL(string : data.userImage)
        let title  = data.title
        let tags   = "タグ : " + data.tags.joinWithSeparator(",")
        let body   = data.body
        let userId = data.userId
        
        if let date = data.updatedAt.transformNSDateGmt() {
            let dateString = date.transformToString("yyyy年MM月dd日") + " 更新"
            data.viewUpdatedAt = Driver.just(dateString)
        }
        
        data.viewThumbnail   = Driver.just(thumbnailUrl)
        data.viewIdWithTitle = Driver.just(title)
        data.viewTags        = Driver.just(tags)
        data.viewBody        = Driver.just(body)
        data.viewUserId      = Driver.just(userId)
        
        return data
    }
}