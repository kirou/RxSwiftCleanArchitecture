//
//  ListUseCaseTests.swift
//  RxSwiftCleanArchitecture
//
//  Created by kirou_16 on 2016/08/14.
//  Copyright © 2016年 tamayuru. All rights reserved.
//

import Foundation
import XCTest
@testable import RxSwiftCleanArchitecture
import RxSwift
import RxTests

class ListUseCaseTests : XCTestCase {
    
    var disposeBag : DisposeBag!
    var scheduler : TestScheduler!
    
    override func setUp() {
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
    }
    
    func testUseCaseNormal() {
    }
    
}