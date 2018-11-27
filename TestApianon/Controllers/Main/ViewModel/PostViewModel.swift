//
//  PostViewModel.swift
//  TestApianon
//
//  Created by Dmitry Muravev on 25/11/2018.
//  Copyright © 2018 Dmitry Muravev. All rights reserved.
//

import RealmSwift
import RxSwift
import RxCocoa

class PostViewModel {
    var postModels = BehaviorRelay<[PostModel]>(value: [])
    
    var notificationToken: NotificationToken?
    
    init() {
        
        let results = StorageManager.shared.getPosts()

        notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
            self?.postModels.accept(StorageManager.shared.getPosts().toArray())
        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }
}
