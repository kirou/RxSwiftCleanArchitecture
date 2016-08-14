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
class QiitaItemCommentEntities {
    var contentsList : [QiitaItemCommentEntity] = []
}

class QiitaItemCommentEntity : Mappable {
    
    // contents
    dynamic var body : String                   = ""
    dynamic var createdAt : String              = ""
    dynamic var id : String                     = ""
    dynamic var renderedBody : String           = ""
    dynamic var updatedAt : String              = ""
    dynamic var userDescription : String        = ""
    dynamic var userFacebookId : String         = ""
    dynamic var userFolloweesCount : Int        = 0
    dynamic var userFollowersCount : Int        = 0
    dynamic var userGithubLoginName : String    = ""
    dynamic var userId : String                 = ""
    dynamic var userItemCount : Int             = 0
    dynamic var userLinkedinId : String         = ""
    dynamic var userLocation : String           = ""
    dynamic var userName : String               = ""
    dynamic var userOrganization : String       = ""
    dynamic var userPermanentId : Int           = 0
    dynamic var userProfileImageUrl : String    = ""
    dynamic var userTwitterScreenName : String  = ""
    dynamic var userwebSiteUrl : String         = ""
    
    required convenience init? (_ map : Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        body    <- map["body"]
        createdAt  <- map["created_at"]
        id         <- map["id"]
        renderedBody    <- map["rerendered_body"]
        updatedAt       <- map["updated_at"]
        userDescription  <- map["user.description"]
        userFacebookId    <- map["user.facebook_id"]
        userFolloweesCount <- map["user.followees_count"]
        userFollowersCount  <- map["user.followers_count"]
        userGithubLoginName <- map["user.github_login_name"]
        userId              <- map["user.id"]
        userItemCount       <- map["user.items_count"]
        userLinkedinId      <- map["user.linkedin_id"]
        userLocation        <- map["user.location"]
        userName            <- map["user.name"]
        userOrganization    <- map["user.organization"]
        userPermanentId     <- map["user.permanent_id"]
        userProfileImageUrl <- map["user.profile_image_url"]
        userTwitterScreenName <- map["user.twitter_screen_name"]
        userwebSiteUrl        <- map["user.website_url"]
    }
}