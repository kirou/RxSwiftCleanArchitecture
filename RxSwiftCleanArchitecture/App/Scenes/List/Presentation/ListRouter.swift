//
//  ListRouter.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/13.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

/**
 *　ページ遷移先
 * 正直なところ、ViewControllerにおいたままでも良い気がしています。
 * weakとはいえ、viewControllerとpresenterを渡しているのがなんとも…
 */

import Foundation
import UIKit

protocol ListRouterProtocol {
    func navigateToDetailScenes(index index : Int)
}

class ListRouter : ListRouterProtocol {
    
    weak private var viewController : ListViewController!
    
    init (viewController : ListViewController) {
        self.viewController = viewController
    }
    
    func navigateToDetailScenes(index index : Int) {
        
        let viewController = UIStoryboard.instantiateViewController(
            storyboardName: StoryboardName.DetailPage,
            viewControllerId: StoryboardName.DetailPage.rawValue,
            type : DetailViewController.self)
        
        let model = self.viewController.models.selectedData(index: index)
        viewController.itemId    = model.valueObject.id
        viewController.itemTitle = model.valueObject.title
        
        self.viewController.navigationController?.pushViewController(viewController, animated: true)
    }
}
