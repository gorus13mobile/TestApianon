//
//  Router.swift
//  TestApianon
//
//  Created by Dmitry Muravev on 25/11/2018.
//  Copyright © 2018 Dmitry Muravev. All rights reserved.
//

import Foundation
import Alamofire

enum Router : URLRequestConvertible {
    
    case getPosts()
    
    private var urlEncoder: ParameterEncoding {
        return Alamofire.URLEncoding()
    }
    private var jsonEncoder: ParameterEncoding {
        return Alamofire.JSONEncoding()
    }
    
    static let baseURL = "https://dev.apianon.ru:3001"
    
    var method : Alamofire.HTTPMethod {
        switch self {
        case .getPosts():
            return .post
        }
    }
    
    var path : String {
        switch self {
        case .getPosts(_):
            return "/posts/get"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let requestUrl = URL(string: Router.baseURL + path)
        let request = try URLRequest(url: requestUrl!, method: method)
        
        /*
        switch self {
        case .login(let params):
            request = try jsonEncoder.encode(request, with: params)
            break
        default:
            break
        }*/
        
        //authorize
        //if (self != .silentLogin([String: Any]())) && (self != .login([String: Any]())) && (self != .refreshToken([String: Any]())) {
        //    if let accessToken = UserModel.currentUser?.token {
        //        request.setValue("JWT \(accessToken)", forHTTPHeaderField: "Authorization")
        //    }
        //}
        
        return request
    }
}
