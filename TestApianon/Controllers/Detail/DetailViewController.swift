//
//  DetailViewController.swift
//  TestApianon
//
//  Created by Dmitry Muravev on 25/11/2018.
//  Copyright © 2018 Dmitry Muravev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {

    var viewModel: DetailViewModel?
    private let disposeBag = DisposeBag()

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!

    var postId = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }

    func applyModel(postId: Int) {
        self.postId = postId
    }

    func configureView() {
        viewModel = DetailViewModel(postId: self.postId)

        self.viewModel?.text
                .asObservable()
                .map { $0 }
                .bind(to:self.textLabel.rx.text)
                .disposed(by:self.disposeBag)
    }

}
