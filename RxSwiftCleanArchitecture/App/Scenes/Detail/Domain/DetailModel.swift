//
//  DetailModel.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/11.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

import Foundation
import RxCocoa

class DetailModelsList {
    var contentsList : [String : DetailModels] = [:]
    
    func getCommentData() -> DetailModels? {
        return contentsList["comment"]
    }
    
    func getStockerData() -> DetailModels? {
        return contentsList["stocker"]
    }
}

class DetailModels {
    var contentsList : [DetailModel] = []
    
    func selectedData(index index : Int) -> DetailModel {
        return contentsList[index]
    }
}

class DetailModel {
    
    // QiitaItemEntityにあるデータの中から表示に必要なものだけ記載する
    var commentId : String    = ""
    var commentBody : String = ""
    var stockerUserId : String    = ""
    
    // View用 (必要性を感じなければ、上にあるPropertyをそのまま利用でもいいです)
    var viewIdWithTitle : Driver<String> = Driver.just("")
    var viewUpdatedAt : Driver<String>   = Driver.just("")
    var viewTags : Driver<String>        = Driver.just("")
    var viewThumbnail : Driver<NSURL?>   = Driver.just(nil)
    var viewBody : Driver<String>        = Driver.just("")
    var viewUserId : Driver<String>      = Driver.just("")
    
    init() {
    }
    
    init(data : QiitaItemCommentEntity) {
        self.commentId   = data.id
        self.commentBody = data.body
    }
    
    init(data : QiitaItemStockerEntity) {
        self.stockerUserId = data.id
    }
    
}
