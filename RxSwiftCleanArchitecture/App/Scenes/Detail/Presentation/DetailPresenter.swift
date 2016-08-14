//
//  DetailPresenter.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/12.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol DetailPresenterProtocol : class {
    var viewModels : DetailModelsList {get}
    func load(itemId itemId : String)
}

class DetailPresenter : DetailPresenterProtocol {
    
    var useCase : DetailUseCaseProtocol!
    
    // 公開
    private(set) var viewModels : DetailModelsList = DetailModelsList()
    
    // 非公開
    private let disposeBag = DisposeBag()
    
    init (useCase : DetailUseCaseProtocol) {
        self.useCase = useCase
    }
    
    deinit {
    }
}

extension DetailPresenter {
    
    func load(itemId itemId : String) {
        
        /*
        Observable.just(true)
            .flatMap { [unowned self] _ in
                return self.useCase.loadData(itemId : itemId)
            }
            .debug()
            .subscribe(
                onNext : { data in
                    print(data)
                },
                onError : { error in
                },
                onCompleted : { _ in
                }
            ).addDisposableTo(disposeBag)
 */
    }
}
