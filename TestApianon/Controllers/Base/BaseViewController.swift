//
//  BaseViewController.swift
//  TestApianon
//
//  Created by Dmitry Muravev on 25/11/2018.
//  Copyright © 2018 Dmitry Muravev. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: navigation helpers

    private func pushTo(controller: UIViewController?, animated: Bool) {
        if let controller = controller {
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
