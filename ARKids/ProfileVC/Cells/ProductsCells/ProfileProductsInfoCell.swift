//
//  ProfileProductsInfoCell.swift
//  ARKids
//
//  Created by Alexander on 25.09.2019.
//  Copyright © 2019 Victor Sobolev. All rights reserved.
//

import UIKit

class ProfileProductsInfoCell: UITableViewCell, UserConfigurable {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(user: User) {}
}
