//
//  MarketVC.swift
//  ARKids
//
//  Created by Victor Sobolev on 25/09/2019.
//  Copyright © 2019 Victor Sobolev. All rights reserved.
//

import UIKit

final class MarketViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let cellIdentifier = String(describing: ProfileProductsCell.self)
    
    private var products = [Product]()
    private let user = UserService.shared.getUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        products = ProductService.getProducts()
        
        title = "Market"
        
        tableView.contentInset.top = 20
        
        tableView.dataSource = self
        tableView.rowHeight = 260
        tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        setupTransparentNavBar()
    }

}

extension MarketViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProfileProductsCell
        let isBought = user.products.contains(where: { $0.title == products[indexPath.row].title })
        cell.configure(product: products[indexPath.row], isBought: isBought, isBuyButtonHidden: false, boost: nil)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
}
