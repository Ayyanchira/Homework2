//
//  MyCustomTableViewCell.swift
//  Homework2
//
//  Created by Ayyanchira, Akshay Murari on 10/9/17.
//  Copyright © 2017 Shehab, Mohamed. All rights reserved.
//

import UIKit

class MyCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var otherImage: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    var thumbnailImageURL:URL?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
