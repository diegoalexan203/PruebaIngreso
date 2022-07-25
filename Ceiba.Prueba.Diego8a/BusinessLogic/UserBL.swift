//
//  UserBL.swift
//  Ceiba.Prueba.Diego8a
//
//  Created by Diego Ochoa on 24/07/22.
//

import Alamofire
import Foundation
import Moya
import RxSwift

class UserBL:UsersBlBehavior {

    var postsRepository: UserRepositoryBehavior


    init(repository: UserRepositoryBehavior) {
        postsRepository = repository
    }

    init(){
        postsRepository = UserRepository()
    }
    func getUsers() throws -> Observable<[User]> {
        return try postsRepository.getUsers().asObservable().flatMap({
            response -> Observable<[User]> in
            Observable.just(response)
        })
    }

    func getPosts(id: String) throws -> Observable<[Post]> {
        return try postsRepository.getPosts(id: id).asObservable().flatMap({
            response -> Observable<[Post]> in
            Observable.just(response)
        })
    }

}

