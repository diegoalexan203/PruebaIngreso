//
//  UserApi.swift
//  Ceiba.Prueba.Diego8a
//
//  Created by Diego Ochoa on 24/07/22.
//

import Foundation
import Moya

public enum UserApi{
    case getPosts(id: String)
    case getUsers
}

extension UserApi : TargetType{
    
    public var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com/")!
    }
    
    public var path: String {
        switch self {
        case .getUsers:
            return UrlServicesHelper.getUsers.description
        case .getPosts:
            return UrlServicesHelper.getPosts.description
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getUsers:
            return .get
        case .getPosts:
            return .get
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .getUsers:
            return Data()
        case .getPosts:
            return Data()
        }
    }
    
    public var task: Task {
        switch self {
        case .getUsers:
            return .requestPlain
            
        case .getPosts(let id):
            return .requestParameters(parameters: ["userId": id], encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .getUsers:
            return nil
        
        case .getPosts:
            return nil
        }
    }
    

}

