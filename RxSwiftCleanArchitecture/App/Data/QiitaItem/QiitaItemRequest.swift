//
//  WikipediaRequest.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/07.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

import RxSwift
import ObjectMapper
import SwiftyJSON

class QiitaItemRequest {
    
    let url = "https://qiita.com/api/v2/items"
    let apiClient = ApiClient.sharedInstance
    
    init () {
    }
    
    func fetch(params params : [String : AnyObject], retryCount : Int) -> Observable<QiitaItemEntities> {
        
        return apiClient.request(method: .GET, url: url, params: [:])
            .retry(retryCount)
            .map { [weak self] (data, response) in
                guard let qiitaItemEntities = self?.createResponse(data: data) else {
                    throw ErrorHandring.Request.ParseError
                }
                return qiitaItemEntities
            }
    }
}

private extension QiitaItemRequest {
    
    func createResponse(data data : NSData) -> QiitaItemEntities? {
        
        let jsonData = JSON(data: data)
        
        guard let data = jsonData.arrayObject else { return nil }
        guard let itemData = Mapper<QiitaItemEntity>().mapArray(data) else { return nil }
        
        let qiitaItemEntities = QiitaItemEntities()
        qiitaItemEntities.contentsList = itemData
        
        return qiitaItemEntities
    }
}