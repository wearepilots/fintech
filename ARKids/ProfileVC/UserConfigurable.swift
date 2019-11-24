//
//  UserConfigurable.swift
//  ARKids
//
//  Created by Alexander on 25.09.2019.
//  Copyright © 2019 Victor Sobolev. All rights reserved.
//

import UIKit

protocol UserConfigurable: UITableViewCell {
    
    func configure(user: User)
}
