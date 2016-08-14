//
//  DetailTranslater.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/11.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

import Foundation

class DetailTranslater {
    
    static func generate(qiitaCommentItems qiitaCommentItems : QiitaItemCommentEntities, qiitaStockerItems : QiitaItemStockerEntities) -> DetailModelsList {
        
        let modelsList = DetailModelsList()
        modelsList.contentsList["comment"] = DetailTranslater.generate(qiitaItems: qiitaCommentItems)
        modelsList.contentsList["stocker"] = DetailTranslater.generate(qiitaItems: qiitaStockerItems)
        
        return modelsList
    }
    
    static func generate(qiitaItems qiitaItems : QiitaItemCommentEntities) -> DetailModels {
        
        let model = DetailModels()
        qiitaItems.contentsList.forEach { entity -> () in
            let data = DetailModel(data : entity)
            model.contentsList.append(data)
        }
        
        return model
    }
    
    static func generate(qiitaItems qiitaItems : QiitaItemStockerEntities) -> DetailModels {
        
        let model = DetailModels()
        qiitaItems.contentsList.forEach { entity -> () in
            let data = DetailModel(data : entity)
            model.contentsList.append(data)
        }
        
        return model
    }
}