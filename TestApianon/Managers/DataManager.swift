//
//  DataManager.swift
//  TestApianon
//
//  Created by Dmitry Muravev on 25/11/2018.
//  Copyright © 2018 Dmitry Muravev. All rights reserved.
//

import Foundation
import RealmSwift

class DataManager {
    
    static let shared = DataManager()
    
    private init() {
    }
    
    func getPosts(complete: (( _ error: Error?) -> ())?) {
        
        ApiManager.shared.getPosts { (postModels, error) in
            if postModels != nil {
                
                StorageManager.shared.deleteAllPosts()
                StorageManager.shared.save(objects: postModels!, update: true)
                
                complete?(nil)
            } else {
                complete?(error)
            }
        }
    }
}
