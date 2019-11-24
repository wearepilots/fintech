//
//  ProfileInfoCell.swift
//  ARKids
//
//  Created by Admin on 25.09.2019.
//  Copyright © 2019 Victor Sobolev. All rights reserved.
//

import UIKit

class ProfileInfoCell: UITableViewCell, UserConfigurable {

    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(user: User) {
        infoLabel.text = user.info
    }
}
