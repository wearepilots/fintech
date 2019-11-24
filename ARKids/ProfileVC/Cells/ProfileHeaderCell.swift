//
//  ProfileHeaderCell.swift
//  ARKids
//
//  Created by Admin on 25.09.2019.
//  Copyright © 2019 Victor Sobolev. All rights reserved.
//

import UIKit

protocol ProfileHeaderCellDelegate: AnyObject {
    
    func marketButtonDidTap()
}

class ProfileHeaderCell: UITableViewCell, UserConfigurable {

    @IBOutlet weak var jobImageView: UIImageView!
    @IBOutlet weak var marketButton: UIButton!
    
    weak var delegate: ProfileHeaderCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        marketButton.layer.cornerRadius = marketButton.frame.height / 2
        marketButton.layer.masksToBounds = true
    }
    
    func configure(user: User) {
        jobImageView.image = user.job.image
    }
    
    @IBAction func marketButtonDidTap(_ sender: Any) {
        delegate?.marketButtonDidTap()
    }
}
