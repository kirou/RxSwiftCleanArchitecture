//
//  UIStoryboard+Util.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/13.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    static func instantiateViewController<T:UIViewController>(storyboardName storyboard : StoryboardName, viewControllerId : String!, type : T.Type) -> T {
        
        let storyboard = UIStoryboard(name : storyboard.rawValue, bundle : nil)
        return storyboard.instantiateViewControllerWithIdentifier(viewControllerId) as! T
    }
}
