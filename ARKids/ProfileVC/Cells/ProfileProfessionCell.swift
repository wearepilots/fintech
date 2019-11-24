//
//  ProfileProfessionCell.swift
//  ARKids
//
//  Created by Admin on 25.09.2019.
//  Copyright © 2019 Victor Sobolev. All rights reserved.
//

import UIKit

class ProfileProfessionCell: UITableViewCell, UserConfigurable {

    @IBOutlet weak var workImage: UIImageView!
    @IBOutlet weak var workView: UIView!
    @IBOutlet weak var workTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        workView.layer.cornerRadius = 6
        workView.layer.masksToBounds = true
    }

    func configure(user: User) {
        workTitle.text = user.job.title
        workImage.image = user.job.image
    }
}
