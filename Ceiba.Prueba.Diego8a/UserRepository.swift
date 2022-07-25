//
//  UserRepository.swift
//  Ceiba.Prueba.Diego8a
//
//  Created by Diego Ochoa on 24/07/22.
//

import Foundation
import Moya
import RxSwift
import Alamofire

class UserRepository: UserRepositoryBehavior {
    
    let api = MoyaProvider<UserApi>(session :  Alamofire.Session.init())
    func getUsers() throws -> Observable<[User]> {
        api.rx.request(UserApi.getUsers).asObservable().flatMap({ Response -> Observable<[User]> in
            
            if Response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let resultGetUsers = try decoder.decode([User].self, from: Response.data)
                    return Observable.just(resultGetUsers)
                }
            } else {
                let error = NSError(domain: "Error PostsApi", code: Response.statusCode, userInfo: ["Error": Response.statusCode.description])
                return Observable.error(error)
            }
        })
    }
    
    func getPosts(id: String) throws -> Observable<[Post]> {
        return api.rx.request(UserApi.getPosts(id: id)).asObservable().flatMap({ Response -> Observable<[Post]> in

            if Response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let resultGetPosts = try decoder.decode([Post].self, from: Response.data)
                    return Observable.just(resultGetPosts)
                }
            } else {
                let error = NSError(domain: "Error PostsApi", code: Response.statusCode, userInfo: ["Error": Response.statusCode.description])
                return Observable.error(error)
            }

        })
    }
    
}
