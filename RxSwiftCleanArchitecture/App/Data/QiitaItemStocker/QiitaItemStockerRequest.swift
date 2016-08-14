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

class QiitaItemStockerRequest {
    
    let prefixUrl = "https://qiita.com/api/v2/items"
    let apiClient = ApiClient.sharedInstance
    
    init () {
    }
    
    func fetch(params params : [String : AnyObject], retryCount : Int) -> Observable<QiitaItemStockerEntities> {
        
        guard let itemId = params["itemId"] as? String else {
            return Observable.just(QiitaItemStockerEntities())
        }
        
        let url = prefixUrl + itemId + "/stockers"
        
        //let realm = try! Realm()
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

private extension QiitaItemStockerRequest {
    
    func createResponse(data data : NSData) -> QiitaItemStockerEntities? {
        
        let jsonData = JSON(data: data)
        
        guard let data = jsonData.arrayObject else { return nil }
        guard let itemData = Mapper<QiitaItemStockerEntity>().mapArray(data) else { return nil }
        
        let qiitaItemEntities = QiitaItemStockerEntities()
        qiitaItemEntities.contentsList = itemData
        
        return qiitaItemEntities
    }
}
