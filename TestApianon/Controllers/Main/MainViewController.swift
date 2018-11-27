//
//  MainViewController.swift
//  TestApianon
//
//  Created by Dmitry Muravev on 25/11/2018.
//  Copyright © 2018 Dmitry Muravev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: BaseViewController {
    
    var viewModel: PostViewModel?
    private let disposeBag = DisposeBag()

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.isHidden = true
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(R.nib.postTableViewCell)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        loadData()
    }
    
    func loadData() {
        
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
        
        DataManager.shared.getPosts { [weak self] (error) in
            self?.activityIndicatorView.isHidden = true
        }
    }
    
    func configureView() {
        
        viewModel = PostViewModel()
        
        viewModel?.postModels.asObservable().bind(to: tableView.rx.items(cellIdentifier: R.nib.postTableViewCell.identifier,
                                                                          cellType: PostTableViewCell.self)) {  row, element, cell in
                                                                            cell.postModel = element
            }
            .disposed(by: disposeBag)
        
        
        tableView.rx
            .modelSelected(PostModel.self)
            .subscribe(onNext:  { [weak self] value in
                if let selectedIndexPath = self?.tableView?.indexPathForSelectedRow {
                    self?.tableView.deselectRow(at: selectedIndexPath, animated: true)
                }
                self?.navigateToDetail(postId: value.id)
            })
            .disposed(by: disposeBag)
    }
}
