//
//  DetailViewModel.swift
//  TestApianon
//
//  Created by Dmitry Muravev on 26/11/2018.
//  Copyright © 2018 Dmitry Muravev. All rights reserved.
//

import RealmSwift
import RxSwift
import RxCocoa

class DetailViewModel {
    var postModel = PostModel()

    var text = BehaviorRelay<String>(value: "")

    var notificationToken: NotificationToken?

    var postId = 0

    init(postId: Int) {
        self.postId = postId

        postModel = StorageManager.shared.getPost(id: self.postId)!
        text.accept(postModel.text)

        notificationToken = postModel.observe { [weak self] change in
            switch change {
            case .change(let properties):
                for property in properties {
                    if property.name == "text" {
                        self?.text.accept(property.newValue as! String)
                    }
                }
            case .deleted:
                print("The object was deleted.")
            case .error(let error):
                print("An error occurred: \(error)")
            }
        }
    }

    deinit {
        notificationToken?.invalidate()
    }
}
