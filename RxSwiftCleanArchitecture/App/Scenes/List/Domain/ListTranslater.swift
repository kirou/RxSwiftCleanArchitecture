//
//  ListTranslater.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/11.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

/**
 * Entity -> Modelを生成する処理
 * 
 * 複数APIなどでリクエストした場合、DataStoreから流れるEntityの型クラスが複数出てくると思うので
 * その数分だけgenerateメソッドを用意する
 * (genericsとかでイイカンジにできるのであれば素敵だと思います。
 *  ただEntityがprotocolで定義できるようなものでないと難しいかなと思っています。いいアイデア募集中)
 *
 */

import Foundation

class ListTranslater {
    
    static func generate(qiitaItems qiitaItems : QiitaItemEntities) -> ListModels {
        
        let model = ListModels()
        qiitaItems.contentsList.forEach { entity -> () in
            let data = ListModel(data : entity)
            model.contentsList.append(data)
        }
        
        return model
    }
}