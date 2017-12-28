//
//  ArticleCell.swift
//  Decoding
//
//  Created by Mr_Xu on 2017/12/15.
//  Copyright © 2017年 Mr_xc. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var snipLable: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var publishLable: UILabel!
    @IBOutlet weak var img: UIImageView!
    private let formatter = DateFormatter()
    var model: ArticleModel? {
        didSet {
            guard let model = model else { return }
            snipLable.text = model.snippet
            titleLable.text = model.title
            publishLable.text = model.published//formatter.string(from: !)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        formatter.dateFormat = "MMM d, h:mm a"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
