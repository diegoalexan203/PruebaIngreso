//
//  Post.swift
//  Ceiba.Prueba.Diego8a
//
//  Created by Diego Ochoa on 24/07/22.
//

import Foundation
class Post: Codable, Equatable {
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.body == rhs.body && rhs.id == lhs.id && rhs.title == lhs.title && rhs.userId == lhs.userId
    }
    
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
    
    init() {
    }
    
    init(userId: Int?, id: Int?, title: String?, body: String?) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
}
