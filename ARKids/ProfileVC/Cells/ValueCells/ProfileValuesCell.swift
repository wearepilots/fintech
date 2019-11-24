//
//  ProfileValuesCell.swift
//  ARKids
//
//  Created by Alexander on 25.09.2019.
//  Copyright © 2019 Victor Sobolev. All rights reserved.
//

import UIKit

class ProfileValuesCell: UITableViewCell, UserConfigurable {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let cellIdentifier = String(describing: ProfileValueCell.self)
    
    var user: User?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func configure(user: User) {
        self.user = user
        
        collectionView.reloadData()
    }
}

extension ProfileValuesCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ProfileValueCell
        
        if let skill = user?.skills[indexPath.row] {
            cell?.configure(skill: skill)
        }
        
        cell?.layoutIfNeeded()
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user?.skills.count ?? 0
    }
}
