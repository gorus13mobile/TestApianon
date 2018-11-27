//
//  PostModel.swift
//  TestApianon
//
//  Created by Dmitry Muravev on 25/11/2018.
//  Copyright © 2018 Dmitry Muravev. All rights reserved.
//

import RealmSwift
import ObjectMapper

class PostModel: Object, Mappable {
    
    @objc dynamic var id = 0
    @objc dynamic var text = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        text <- map["text"]
    }
}

