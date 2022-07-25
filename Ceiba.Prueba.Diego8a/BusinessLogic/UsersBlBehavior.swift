//
//  UsersBlBehavior.swift
//  Ceiba.Prueba.Diego8a
//
//  Created by Diego Ochoa on 24/07/22.
//

import Foundation
import RxSwift

protocol UsersBlBehavior {
    func getPosts(id: String) throws -> Observable<[Post]>
    func getUsers() throws -> Observable<[User]>
}
