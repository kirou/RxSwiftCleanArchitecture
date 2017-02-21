//
//  ListPresenterTests.swift
//  RxSwiftCleanArchitecture
//
//  Created by kirou_16 on 2016/08/14.
//  Copyright © 2016年 tamayuru. All rights reserved.
//

import XCTest
@testable import RxSwiftCleanArchitecture

import RxSwift
import RxTest

class ListPresenterCaseTests : XCTestCase {
    
    var disposeBag : DisposeBag!
    var scheduler : TestScheduler!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testUseCaseNormal() {
        
        let loading = scheduler.createObserver(Bool)
        
        let presenter = ListPresenter(useCase : QiitaItemNormalTestUseCase())
        
        // subscribeNext時に利用するSubjectから通知が来るか
        presenter.viewReloadData
            .asObserver()
            .bindTo(loading)
            .addDisposableTo(disposeBag)
        
        // データが何件流れてくるか
        let elementsCount = scheduler.createObserver(Int)
        presenter.viewReloadData
            .asObserver()
            .map { _ -> Int in return presenter.viewModels.contentsList.count }
            .bindTo(elementsCount)
            .addDisposableTo(disposeBag)
        
        scheduler.scheduleAt(100) { presenter.viewReloadData.onNext(true) }
        scheduler.scheduleAt(200) { presenter.viewReloadData.onNext(false) }
        scheduler.scheduleAt(500) { presenter.load() }
        scheduler.start()
        
        XCTAssertEqual(loading.events, [
            next(100, true),
            next(200, false),
            next(500, true),
            ])
        
        XCTAssertEqual(elementsCount.events, [
            next(100, 0),
            next(200, 0),
            next(500, 10),
            ])
    }
    
    func testUseCaseError() {
        
        let presenter = ListPresenter(useCase : QiitaItemNormalTestUseCase())
        
        // subscribeError時に利用するSubjectから通知が来るか
        presenter.viewErrorPage.asObserver().subscribeNext {
            XCTAssertTrue($0)
        }.addDisposableTo(disposeBag)
        
        presenter.load()
    }
}

class QiitaItemNormalTestUseCase : ListUseCaseProtocol {
    func loadData() -> Observable<ListModels> {
        let listModels = ListModels()
        // 10件つくる
        for _ in 0..<10 {
            listModels.contentsList.append(ListModel())
        }
        return Observable.just(listModels)
    }
}

class QiitaItemErrorTestUseCase : ListUseCaseProtocol {
    func loadData() -> Observable<ListModels> {
        return Observable.just().map {
            throw ErrorHandring.Request.EmptyData
        }
    }
}
