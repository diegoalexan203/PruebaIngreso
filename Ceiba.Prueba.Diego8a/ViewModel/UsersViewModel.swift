//
//  UsersViewModel.swift
//  Ceiba.Prueba.Diego8a
//
//  Created by Diego Ochoa on 24/07/22.
//

import Foundation
import RxCocoa
import RxSwift

class UsersViewModel: ViewModelProtocol {
    let disposeBag = DisposeBag()
    let usersDB = DBHelper()
    var userBl: UsersBlBehavior

    struct Input {
        var viewShow = BehaviorRelay<Bool?>(value: false)
    }

    struct Output {
        var users = BehaviorRelay<[User]?>(value: nil)
        var loading = BehaviorRelay<Bool?>(value: false)
    }

    let input: Input
    let output: Output

    init(userBl: UsersBlBehavior) {
        input = Input()
        output = Output()
        self.userBl = userBl
        bind()
        deleteDataBase()
    }

    init() {
        input = Input()
        output = Output()
        userBl = UserBL(repository: UserRepository())
        bind()
    }
    
    func bind() {
        output.loading.accept(true)
        input.viewShow.subscribe(onNext: { show in

            if show ?? false {
                if !self.usersDB.usersTableHasData() {
                    self.getUsersFromApi()
                }

                self.showUsers()
            }

        }).disposed(by: disposeBag)
    }

    func getUsersFromApi() {
        do {
            try userBl.getUsers().asObservable().retry(1)
                .subscribe(onNext: { response in
                    let users = response
                    for user in users {
                        self.usersDB.create(user: user)
                    }
                    self.showUsers()
                })
        } catch {
            print("Error", "No se pudo cargar el servicio")
        }
    }
    
    func showUsers() {
        output.users.accept(usersDB.getUsers())
        output.loading.accept(false)
    }
    
    func deleteDataBase() {
        usersDB.deleteAll()
    }
}
