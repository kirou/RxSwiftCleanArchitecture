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

/**
 * QiitaEntityのリスト
 */
class QiitaItemStockerEntities {
    var contentsList : [QiitaItemStockerEntity] = []
}

class QiitaItemStockerEntity : Mappable {
    
    // contents
    dynamic var stockerDescription: String  = ""
    dynamic var facebookId : String         = ""
    dynamic var followeesCount : Int        = 0
    dynamic var gitHubLoginName : String    = ""
    dynamic var id : String                 = ""
    dynamic var itemsCount : Int            = 0
    dynamic var linkedinId : String         = ""
    dynamic var location : String           = ""
    dynamic var name : String               = ""
    dynamic var organization : String       = ""
    dynamic var permanentId : Int           = 0
    dynamic var profileImageUrl : String    = ""
    dynamic var twitterScreenName : String  = ""
    dynamic var webSiteUrl : String         = ""
    
    required convenience init? (_ map : Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        stockerDescription <- map["description"]
        facebookId         <- map["facebook_id"]
        followeesCount     <- map["followees_count"]
        gitHubLoginName    <- map["github_login_name"]
        id                 <- map["id"]
        itemsCount         <- map["items_count"]
        linkedinId         <- map["linkedin_id"]
        location           <- map["location"]
        name               <- map["name"]
        organization       <- map["organization"]
        permanentId        <- map["permanent_id"]
        profileImageUrl    <- map["profile_image_url"]
        twitterScreenName  <- map["twitter_screen_name"]
        webSiteUrl         <- map["website_url"]
    }
}