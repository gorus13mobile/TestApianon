//
//  ApiManager.swift
//  TestApianon
//
//  Created by Dmitry Muravev on 25/11/2018.
//  Copyright © 2018 Dmitry Muravev. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

import SwiftyJSON

class ApiManager {
    
    static let shared = ApiManager()
    private init() {}
    
    typealias ErrorCompletion = (Error?, String?) -> Void

    typealias GroupsCompletion = ([PostModel]?, Error?) -> Void
    
    func getPosts(completion: @escaping GroupsCompletion) {
        Alamofire.request(Router.getPosts())
            .validate(statusCode: 200..<300)
            .responseArray(keyPath: "data") { (response: DataResponse<[PostModel]>) in
                
                if let item = response.result.value {
                    completion(item, nil)
                } else {
                    response.logError()
                    completion(nil, response.result.error)
                }
        }
    }
}
