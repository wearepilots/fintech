//
//  UserService.swift
//  ARKids
//
//  Created by Alexander on 25.09.2019.
//  Copyright © 2019 Victor Sobolev. All rights reserved.
//

import UIKit

final class UserService {
    
    static let shared = UserService()
    static var userProducts: [Product] = []
    static var job: Job = Job(title: "GARDENER", subtitle: "Practices gardening", image: #imageLiteral(resourceName: "gardener"), subImage: #imageLiteral(resourceName: "leaf"))
    
    private init() {}
    
    func getUser() -> User {
        // Jobs
//        let mechanic = Job(title: "GARDENER", subtitle: "Practices gardening", image: #imageLiteral(resourceName: "gardener"), subImage: #imageLiteral(resourceName: "leaf"))

        // Skills
        let skill = Skill(name: "Job", currentLevel: 3, image: UIImage(named: "job")!)
        let skill2 = Skill(name: "Deposit", currentLevel: Balance.deposit, image: UIImage(named: "deposit")!)

        // Product skills
//        let productSkill1 = Skill(name: "Skill1", currentLevel: 30, image: UIImage(named: "leaf")!)
//        let productSkill2 = Skill(name: "Skill2", currentLevel: 60, image: UIImage(named: "leaf")!)
//        let productSkill3 = Skill(name: "Skill3", currentLevel: 10, image: UIImage(named: "leaf")!)

//        // Product
//        let product = Product(title: "Rocket", description: "Improves work speed", image: UIImage(named: "plane"), modelScenePath: nil, price: 300, skills: [productSkill1, productSkill2, productSkill3])
        
        // User
        let user = User(name: "Alex", level: 4, job: UserService.job, info: "Love football, basketball.", skills: [skill, skill2], products: UserService.userProducts)
        
        return user
    }
}
