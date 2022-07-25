//
//  DetailsUserTest.swift
//  Ceiba.Prueba.Diego8aTests
//
//  Created by Diego Ochoa on 25/07/22.
//

import Foundation
import RxCocoa
import RxSwift
import RxTest
import XCTest
@testable import Ceiba_Prueba_Diego8a

class DetailsUserTest: XCTestCase {
    var scheduler: TestScheduler!
    var disposebag: DisposeBag!

    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        disposebag = DisposeBag()
    }

    func testGestPostUserExist() {
        let fake = FakeUserBl()
        let viewModel = DetailsUserPostsViewModel(postsBl: fake)
        viewModel.input.viewShown.accept(true)
        viewModel.input.userId.accept("1")

        let posts = scheduler.createObserver([Post]?.self)
        viewModel.output.posts.asDriver().drive(posts).disposed(by: disposebag)
        
        scheduler.start()
        let postsReturn = viewModel.output.posts.value
        XCTAssertNotNil(postsReturn)
        
    }
}
