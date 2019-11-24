//
//  ProfileProductsCell.swift
//  ARKids
//
//  Created by Alexander on 25.09.2019.
//  Copyright © 2019 Victor Sobolev. All rights reserved.
//

import UIKit

protocol ProfileProductsCellDelegate: AnyObject {
    
    func didTap(cell: UITableViewCell)
}

class ProfileProductsCell: UITableViewCell {

    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var productIcon: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDesciption: UILabel!
    
    @IBOutlet weak var progressView1: UIView!
    @IBOutlet weak var progressView2: UIView!
    @IBOutlet weak var progressView3: UIView!
    
    @IBOutlet weak var skill1: UILabel!
    @IBOutlet weak var skill2: UILabel!
    @IBOutlet weak var skill3: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var premiumButton: UIButton!
    @IBOutlet weak var boostLabel: UILabel!
    
    lazy var progressViews: [UIView] = [progressView1, progressView2, progressView3]
    
    private var product: Product?
    
    weak var delegate: ProfileProductsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundedView.layer.cornerRadius = 8
        roundedView.layer.masksToBounds = true
        
        buyButton.layer.cornerRadius = 8
        buyButton.layer.masksToBounds = true
        
        premiumButton.layer.cornerRadius = 8
        premiumButton.layer.masksToBounds = true
    }
    
    func configure(product: Product, isBought: Bool, isBuyButtonHidden: Bool, boost: String?) {
        
        self.product = product
        
        productIcon.image = product.image
        productName.text = product.title
        productDesciption.text = product.description
        
        buyButton.setTitle(String(product.price) + " $", for: .normal)
        buyButton.isHidden = isBuyButtonHidden
        
        if isBought {
            disableBuyButton()
        }
        
        if let boost = boost {
            boostLabel.isHidden = false
            boostLabel.text = boost
        }
        
        if product.isPremium {
            disableBuyButton()
            premiumButton.isHidden = false
        }
        
        guard product.skills.count > 2 else { return }
        
        skill1.text = product.skills[0].name
        skill2.text = product.skills[1].name
        skill3.text = product.skills[2].name
        
        for i in 0..<progressViews.count {
            progressViews[i].layer.cornerRadius = 6
            progressViews[i].layer.masksToBounds = true
            
            ProgressView.addToView(progressViews[i], progressPercent: product.skills[i].currentLevel, colorLeft: .orange, colorRight: .orange)
        }
    }
    
    @IBAction func buttonDidTap(_ sender: Any) {
        delegate?.didTap(cell: self)
    }
    
    @IBAction func buyButtonDidTap(_ sender: Any) {
        guard let product = product else { return }
        
        guard product.price <= Balance.current else {
            if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
                let alert = UIAlertController(title: "Sorry!", message: "You don't have enough money", preferredStyle: .alert)
                alert.addAction(.init(title: "OK", style: .default, handler: nil))
                rootViewController.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        guard !product.isFinancialInstrument else {
            Balance.deposit += product.price
            if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
                let alert = UIAlertController(title: "Congratulations!", message: "You've just invested in the 0.8% deposit", preferredStyle: .alert)
                alert.addAction(.init(title: "Thanks!", style: .default, handler: nil))
                rootViewController.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        disableBuyButton()
        Balance.current = Balance.current - product.price
        Balance.jobIncome += 2
        UserService.userProducts.append(product)
    }
    
    private func disableBuyButton() {
        buyButton.backgroundColor = .gray
        buyButton.tintColor = .lightGray
        buyButton.isEnabled = false
    }
}
