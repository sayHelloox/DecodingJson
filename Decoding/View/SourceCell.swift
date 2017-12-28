//
//  SourceCell.swift
//  Decoding
//
//  Created by Mr_Xu on 2017/12/15.
//  Copyright © 2017年 Mr_xc. All rights reserved.
//

import UIKit

class SourceCell: UITableViewCell {

    @IBOutlet weak var categoryLable: UILabel!
    @IBOutlet weak var overViewLable: UILabel!
    @IBOutlet weak var nameLable: UILabel!
    var sourceModel: SourceModel? {
        didSet {
            guard let model = sourceModel else { return }
            categoryLable.text = model.category
            overViewLable.text = model.overview
            nameLable.text = model.name
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
