//
//  BaseViewController+Navigation.swift
//  TestApianon
//
//  Created by Dmitry Muravev on 25/11/2018.
//  Copyright © 2018 Dmitry Muravev. All rights reserved.
//

import UIKit

extension BaseViewController {
    
    //MARK: - Start navigation
    
    class func resetToRootController() {
        //NotificationCenter.default.post(name: .resetRootControllerNotificationName, object: nil)
    }
    
    func resetRootController() {
        BaseViewController.resetToRootController()
    }
    
    func navigateToDetail(postId: Int) {
        let controller = R.storyboard.main.detailViewController()
        controller?.applyModel(postId: postId)
        pushTo(controller: controller, animated: true)
    }

    func navigateToBack() {

        navigationController?.popViewController(animated: true)
    }
    
    //MARK: navigation helpers
    
    private func pushTo(controller: UIViewController?, animated: Bool) {
        if let controller = controller {
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    private func setEmptyBackBarItem() {
        setBackBarItemWith(title: "")
    }
    
    private func setBackBarItemWith(title: String) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
    }
}
