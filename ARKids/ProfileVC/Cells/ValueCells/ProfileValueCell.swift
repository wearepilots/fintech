//
//  ProfileValueCell.swift
//  ARKids
//
//  Created by Alexander on 25.09.2019.
//  Copyright © 2019 Victor Sobolev. All rights reserved.
//

import UIKit

class ProfileValueCell: UICollectionViewCell {

    @IBOutlet weak var skillIcon: UIImageView!
    @IBOutlet weak var skillTitle: UILabel!
    @IBOutlet weak var skillAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
    
    func configure(skill: Skill) {
        skillIcon.image = skill.image
        skillTitle.text = skill.name
        
        if skill.currentLevel > 0 {
            skillAmount.textColor = .green
        } else {
            skillAmount.textColor = .white
        }
        
        skillAmount.text = String(skill.currentLevel) + " $"
        
        if skill.currentLevel > 0 {
            switch skill.name {
            case "Deposit":
                skillAmount.text = String(skill.currentLevel) + " $ " + "+0.8%"
            case "Job":
                skillAmount.text = "+ " + String(Balance.jobIncome) + " $ "
            default: break
            }
        }
    }
}
