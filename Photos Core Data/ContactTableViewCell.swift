//
//  ContactTableViewCell.swift
//  Photos Core Data
//
//  Created by Jack Huffman on 3/19/19.
//  Copyright © 2019 Jack Huffman. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    // contact image
    @IBOutlet weak var contactImage: UIImageView!
    
    // contact labels
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
