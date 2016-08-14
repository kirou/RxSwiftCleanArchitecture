//
//  DetailConfigurator.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/12.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

class DetailConfigurator {
    
    static var sharedInstance = DetailConfigurator()
    
    func configure(viewController : DetailViewController) {
        
        let useCase : DetailUseCase = DetailUseCase(
            qiitaItemStockerRepository : QiitaItemStockerRepository(),
            qiitaItemCommentRepository : QiitaItemCommentRepository()
        )
        
        let presenter : DetailPresenter = DetailPresenter(useCase : useCase)
        
        viewController.presenter = presenter
    }
}