//
//  StorageManager.swift
//  TestApianon
//
//  Created by Dmitry Muravev on 25/11/2018.
//  Copyright © 2018 Dmitry Muravev. All rights reserved.
//

import Foundation
import RealmSwift

class StorageManager {
    static let shared = StorageManager()
    
    private let realmQueue = DispatchQueue(label: "realm_queue")
    
    private init() {
        var config = Realm.Configuration()
        config.schemaVersion = 1
        config.migrationBlock = { migration, oldSchemaVersion in
            if (oldSchemaVersion < 1) {
                
            }
        }
        Realm.Configuration.defaultConfiguration = config
    }
    
    // MARK: - Common read/write methods
    
    private func getObject<T>(block: (Realm) -> T?) -> T? {
        var object: T? = nil
        do {
            let realm = try Realm()
            object = block(realm)
        } catch {
            print("Read error: \(error)")
        }
        return object
    }
    
    func write(block: ((Realm) throws -> ())) {
        realmQueue.sync {
            do {
                let realm = try Realm()
                try realm.write {
                    do {
                        try block(realm)
                    } catch let error {
                        print("Write error: \(error)")
                    }
                }
            } catch {
                print("Write error: \(error)")
            }
        }
    }
    
    // MARK: - Read methods
    
    func getPost(id: Int) -> PostModel? {
        return getObject {
            $0.object(ofType: PostModel.self, forPrimaryKey: id)
        }
    }
    
    func getPosts() -> Results<PostModel> {
        return getObject {
            $0.objects(PostModel.self)
            }!
    }
    
    // MARK: - Write methods
    
    func save(object: Object, update: Bool) {
        write { realm in
            realm.add(object, update: update)
        }
    }
    
    func save(objects: [Object], update: Bool) {
        write { realm in
            realm.add(objects, update: update)
        }
    }
    
    // MARK: - Set methods
    
    
    // MARK: - Delete methods
    
    func clean() {
        write { realm in
            realm.deleteAll()
        }
    }
    
    func delete(object: Object) {
        write { realm in
            realm.delete(object)
        }
    }
    
    func delete(objects: [Object]) {
        write { realm in
            realm.delete(objects)
        }
    }
    
    func deleteAllPosts() {
        delete(objects: getPosts().toArray())
    }
    
}
