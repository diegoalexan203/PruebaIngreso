//
//  UrlServicesHelper.swift
//  Ceiba.Prueba.Diego8a
//
//  Created by Diego Ochoa on 24/07/22.
//

import Foundation
enum UrlServicesHelper: CustomStringConvertible {
    case getPosts
    case getUsers

    var description: String {
        switch self {
        case .getPosts:
            return "posts"
        case .getUsers:
            return "users"
        }
    }
}
