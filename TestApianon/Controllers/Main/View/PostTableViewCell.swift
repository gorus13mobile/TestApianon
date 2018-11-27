//
//  PostTableViewCell.swift
//  TestApianon
//
//  Created by Dmitry Muravev on 25/11/2018.
//  Copyright © 2018 Dmitry Muravev. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var postModel: PostModel? {
        didSet {
            guard let postModel = postModel else { return }
            descLabel.text = postModel.text
        }
    }

}
