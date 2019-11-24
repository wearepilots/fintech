//
//  ProfileBalanceCell.swift
//  ARKids
//
//  Created by Alexander on 25.09.2019.
//  Copyright © 2019 Victor Sobolev. All rights reserved.
//

import UIKit

class ProfileBalanceCell: UITableViewCell, UserConfigurable {

    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundedView.layer.cornerRadius = 8
        roundedView.layer.masksToBounds = true
    }
    
    func configure(user: User) {
        nameLabel.text = user.name
        balanceLabel.text = String(Balance.current) + " $"
    }
}
