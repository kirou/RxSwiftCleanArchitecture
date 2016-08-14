//
//  WikipediaEntity.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/07.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

/**
 *
 * APIなどのデータのEntityクラス
 * このEntityをPresentation層で利用することはありません。
 * Domain層のTranslaterが同じくDomain層にあるModelの型に変換をします。
 */

import ObjectMapper
import RealmSwift

/**
 * QiitaEntityのリスト
 */
class QiitaItemEntities {
    var contentsList : [QiitaItemEntity] = []
}

class QiitaItemEntity : Object, Mappable {
    
    // contents
    dynamic var id : String             = ""
    dynamic var title : String          = ""
    dynamic var url : String            = ""
    dynamic var renderedBody : String   = ""
    dynamic var body : String           = ""
    dynamic var createdAt : String      = ""
    dynamic var updatedAt : String      = ""
    var tags : List<QiitaItemTagEntity> = List<QiitaItemTagEntity>()
    
    
    // user
    dynamic var itemsCount : Int         = 0
    dynamic var profileImageUrl : String = ""
    dynamic var userName : String        = ""
    dynamic var userId : String        = ""
    dynamic var githubLoginName : String = ""
    
    required convenience init? (_ map : Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        id           <- map["id"]
        title        <- map["title"]
        url          <- map["url"]
        renderedBody <- map["rendered_body"]
        body         <- map["body"]
        createdAt    <- map["created_at"]
        updatedAt    <- map["updated_at"]
        tags         <- (map["tags"], ArrayTransform<QiitaItemTagEntity>())
        githubLoginName <- map["user.github_login_name"]
        itemsCount      <- map["user.itemsCount"]
        userName        <- map["user.name"]
        userId          <- map["user.id"]
        profileImageUrl <- map["user.profile_image_url"]
    }
}

class QiitaItemTagEntity : Object, Mappable {
    
    dynamic var name : String = ""
    
    required convenience init? (_ map : Map) {
        self.init()
        mapping(map)
    }
    
    func mapping(map: Map) {
        name <- map["name"]
    }
}
