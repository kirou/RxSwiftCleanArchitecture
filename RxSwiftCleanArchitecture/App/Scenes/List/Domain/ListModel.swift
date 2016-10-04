//
//  ListModel.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/11.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

/**
 *
 * Presentaion層(表示用のProperty定義も含む)で利用するModelを定義します
 * (ViewModelという認識でいいと思っています)
 * そうすることで、DateStoreから取得するデータに変更(型クラスの変更)があっても
 * Domain層の変更だけで、Presentation層に手を加えることがなくなります。
 *
 * また、DataStoreから取得したデータをここでModelに変換して、PresenterのところでViewModelを用意することもできますが
 * Sceneの表示に関するデータを集約したモデルとしてここに定義しておくと、責任箇所がはっきりして良いと思っています。
 */

import Foundation

/**
 * TableViewのように、ListModelが複数ある場合、[ListModel]としてもいいですが
 * ○件取得などのattributeがある場合、[ListModel]の他にattribute用の型が必要になっていきます。
 * そのため、ここでさらにそれらをまとめる用のListModelsも記載しておきます。
 * この話はEntity側でも同様です。
 */
class ListModels {
    var contentsList : [ListModel] = []
    
    func selectedData(index index : Int) -> ListModel {
        return self.contentsList[index]
    }
}

class ListModel {
    
    var valueObject : ListValueObject = ListValueObject()
    
    var viewModel : ListViewModel = ListViewModel()
    
    init() {
    }
}

class ListValueObject {
    
    // QiitaItemEntityにあるデータの中から表示に必要なものだけ記載する
    var id : String    = ""
    var title : String = ""
    var tags : [String] = []
    var updatedAt : String = ""
    var body : String = ""
    var userId    : String = ""
    var userImage : String = ""
    
    init () {
        
    }
    
    init(data : QiitaItemEntity) {
        self.id = data.id
        self.title = data.title
        self.updatedAt = data.updatedAt
        self.userImage = data.profileImageUrl
        self.body = data.body
        self.userId = data.userId
        
        data.tags.forEach { element in
            self.tags.append(element.name)
        }
    }
}

class ListViewModel {
    
    // View用 (必要性を感じなければ、上にあるPropertyをそのまま利用でもいいです)
    var viewIdWithTitle : String = ""
    var viewUpdatedAt : String   = ""
    var viewTags : String        = ""
    var viewThumbnail : NSURL?   = nil
    var viewBody : String        = ""
    var viewUserId : String      = ""
    
    init () {
        
    }
}