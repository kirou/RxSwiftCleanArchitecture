//
//  ListConfigurator.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/12.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

/**
 * ここで、依存度注入することによって
 * ViewController / Presenter / UseCase / Repositoryを疎結合にする
 */

class ListConfigurator {
    
    static var sharedInstance = ListConfigurator()
    
    func configure(viewController : ListViewController) {
        
        let useCase : ListUseCase = ListUseCase(
            qiitaItemRepository : QiitaItemRepository()
        )
        
        let presenter : ListPresenter = ListPresenter(useCase : useCase)
        
        let router = ListRouter(viewController: viewController)
        
        viewController.presenter = presenter
        viewController.router = router
    }
}
