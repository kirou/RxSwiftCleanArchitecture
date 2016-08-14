//
//  Dependencies.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/12.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class Dependencies {
    
    let mainScheduler = MainScheduler.instance
    let backgroundScheduler : ImmediateSchedulerType = {
        return ConcurrentDispatchQueueScheduler(globalConcurrentQueueQOS : .UserInteractive)
    }()
    
    static let sharedInstance = Dependencies()
    
    private init() {}
}