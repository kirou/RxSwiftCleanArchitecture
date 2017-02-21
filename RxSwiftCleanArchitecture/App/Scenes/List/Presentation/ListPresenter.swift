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
    var viewReloadData : PublishSubject<ListModels> {get}
    var viewErrorPage : PublishSubject<Bool> {get}
    var isStartActivityIndicator : PublishSubject<Bool> {get}
    
    func load()
}

class ListPresenter : ListPresenterProtocol {
    
    private let useCase : ListUseCaseProtocol!
    
    // 公開
    private(set) var viewReloadData = PublishSubject<ListModels>()
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
        
        Observable.just()
            .doOn { [unowned self] in self.isStartActivityIndicator.onNext(true) }
            .observeOn(Dependencies.sharedInstance.backgroundScheduler)
            .flatMap { [unowned self] in self.useCase.loadData() }
            .observeOn(Dependencies.sharedInstance.mainScheduler)
            .shareReplay(1)
            .doOn { [unowned self] in self.isStartActivityIndicator.onNext(false) }
            .subscribe(
                // ストリームから流れたデータをViewModelsにセット
                onNext : { [weak self] models in
                    
                    guard let weakSelf = self else { return }
                    weakSelf.viewReloadData.onNext(models)
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
                onCompleted : { _ in }
            ).addDisposableTo(disposeBag)
    }
}
