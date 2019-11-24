//
//  ProductService.swift
//  ARKids
//
//  Created by Victor Sobolev on 25/09/2019.
//  Copyright © 2019 Victor Sobolev. All rights reserved.
//

import Foundation
import UIKit

class ProductService {
    static func getProducts() -> [Product] {
        
        let boosted = UserDefaults.standard.bool(forKey: "isBoosted")
        var bikeModel = "art.scnassets/woodenBike.scn"
        let boostedModel = "art.scnassets/coolBike.scn"
        if boosted {
            bikeModel = boostedModel
        }
        let product1 = Product(title: "Stock trading",
                               description: "With teaching program",
                               image: #imageLiteral(resourceName: "trading"),
                               modelScenePath: "art.scnassets/ship.scn",
                               price: 0,
                               isPremium: true,
                               isBoosted: false,
                               isFinancialInstrument: true,
                               skills: [Skill(name: "Risk", currentLevel: 80, image: #imageLiteral(resourceName: "leaf")),
                                        Skill(name: "Expense", currentLevel: 44, image: #imageLiteral(resourceName: "leaf")),
                                        Skill(name: "Profitability", currentLevel: 60, image: #imageLiteral(resourceName: "leaf"))])
        
        let product2 = Product(title: "Property",
                               description: "",
                               image: #imageLiteral(resourceName: "property"),
                               modelScenePath: "art.scnassets/ship.scn",
                               price: 40000,
                               isPremium: false,
                               isBoosted: false,
                               isFinancialInstrument: false,
                               skills: [Skill(name: "Risk", currentLevel: 20, image: #imageLiteral(resourceName: "leaf")),
                                        Skill(name: "Expense", currentLevel: 90, image: #imageLiteral(resourceName: "leaf")),
                                        Skill(name: "Profitability", currentLevel: 15, image: #imageLiteral(resourceName: "leaf"))])
        
        let product3 = Product(title: "Deposit",
                               description: "Safe investments",
                               image: #imageLiteral(resourceName: "deposit"),
                               modelScenePath: "art.scnassets/ship.scn",
                               price: 100,
                               isPremium: false,
                               isBoosted: false,
                               isFinancialInstrument: true,
                               skills: [Skill(name: "Risk", currentLevel: 10, image: #imageLiteral(resourceName: "leaf")),
                                        Skill(name: "Expense", currentLevel: 44, image: #imageLiteral(resourceName: "leaf")),
                                        Skill(name: "Profitability", currentLevel: 20, image: #imageLiteral(resourceName: "leaf"))])
        
        let product4 = Product(title: "Bicycle",
                               description: "Improves work speed",
                               image: #imageLiteral(resourceName: "bicycle"),
                               modelScenePath: bikeModel,
                               price: 300,
                               isPremium: false,
                               isBoosted: boosted,
                               isFinancialInstrument: false,
                               skills: [Skill(name: "Income improvement", currentLevel: 30, image: #imageLiteral(resourceName: "leaf")),
                                        Skill(name: "Expense", currentLevel: 35, image: #imageLiteral(resourceName: "leaf")),
                                        Skill(name: "Easy to sell", currentLevel: 70, image: #imageLiteral(resourceName: "leaf"))])
        
        return [product1, product2, product3, product4]
    }
}

struct Product {
    var title: String!
    var description: String!
    var image: UIImage!
    var modelScenePath: String!
    var price: Int!
    var isPremium: Bool!
    var isBoosted: Bool!
    var isFinancialInstrument: Bool!
    var skills: [Skill]!
}

struct Skill {
    var name: String!
    var currentLevel: Int!
    var image: UIImage!
}
