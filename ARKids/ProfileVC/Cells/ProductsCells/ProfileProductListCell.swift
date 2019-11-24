//
//  ProfileProductListCell.swift
//  ARKids
//
//  Created by Alexander on 25.09.2019.
//  Copyright © 2019 Victor Sobolev. All rights reserved.
//

import UIKit

protocol ProfileProductListCellDelegate: AnyObject {
    func didSelect(product: Product)
}

class SelfSizedTableView: UITableView {
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
}

class ProfileProductListCell: UITableViewCell, UserConfigurable {

    @IBOutlet weak var tableView: SelfSizedTableView!
    
    private let cellIdentifier = String(describing: ProfileProductsCell.self)
    private var user: User?
    
    weak var delegate: ProfileProductListCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 260
        tableView.estimatedRowHeight = 260
        tableView.separatorStyle = .none
    }
    
    func configure(user: User) {
        self.user = user
        tableView.reloadData()
    }
}

extension ProfileProductListCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ProfileProductListCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user?.products.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProfileProductsCell
        
        cell.delegate = self
        if let user = user, !user.products.isEmpty {
            var boostString: String?
            if UserDefaults.standard.bool(forKey: "isBoosted") {
                boostString = "+50% fast"
            }
            cell.configure(product: user.products[indexPath.row], isBought: true, isBuyButtonHidden: true, boost: boostString)
        }
        
        cell.layoutIfNeeded()
        return cell
    }
}

extension ProfileProductListCell:  ProfileProductsCellDelegate {
    
    func didTap(cell: UITableViewCell) {
        guard let user = user, !user.products.isEmpty, let indexPath = tableView.indexPath(for: cell) else { return }
        delegate?.didSelect(product: user.products[indexPath.row])
    }
}
