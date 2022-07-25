//
//  UserTest.swift
//  Ceiba.Prueba.Diego8aTests
//
//  Created by Diego Ochoa on 25/07/22.
//

import RxCocoa
import RxSwift
import RxTest
import XCTest

class UserTest: XCTestCase {

    var scheduler: TestScheduler!
    var disposebag: DisposeBag!

    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        disposebag = DisposeBag()
    }

    func testGetUsersShow() {
        let fake = FakeUserBl()
        let viewModel = UsersViewModel(userBl: fake)
        viewModel.input.viewShow.accept(true)

        let users = scheduler.createObserver([User]?.self)
        viewModel.output.users.asDriver().drive(users).disposed(by: disposebag)

        scheduler.start()

        let usersVM = viewModel.output.users.value
        XCTAssertNotNil(usersVM)
        viewModel.deleteDataBase()
    }

}
