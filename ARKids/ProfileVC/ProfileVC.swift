//
//  ProfileVC.swift
//  ARKids
//
//  Created by Victor Sobolev on 25/09/2019.
//  Copyright © 2019 Victor Sobolev. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonView: UIView!
    
    private let userService = UserService.shared
    private let refreshControl = UIRefreshControl()
    
    private let identifiers: [String] = [
        String(describing: ProfileHeaderCell.self),
        String(describing: ProfileBalanceCell.self),
        String(describing: ProfileProfessionCell.self),
        String(describing: ProfileInfoCell.self),
        String(describing: ProfileValuesCell.self),
        String(describing: ProfileProductsInfoCell.self),
        String(describing: ProfileProductListCell.self)
    ]
    
    private let heights: [CGFloat] = [
        300,
        110,
        80,
        UITableView.automaticDimension,
        150,
        60,
        UITableView.automaticDimension
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0)
        tableView.separatorStyle = .none
        
        refreshControl.addTarget(self, action: #selector(updateTableView), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        identifiers.forEach {
            tableView.register(UINib(nibName: $0, bundle: nil), forCellReuseIdentifier: $0)
        }
        
        setupTransparentNavBar()
        
        buttonView.layer.cornerRadius = 18
        buttonView.layer.masksToBounds = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        tableView.beginUpdates()
        tableView.reloadRows(at: [
            IndexPath(row: 1, section: 0),
            IndexPath(row: 4, section: 0),
            IndexPath(row: 6, section: 0)], with: .fade)
        tableView.endUpdates()
    }

    @objc private func updateTableView() {
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    @IBAction func didTapARButton(_ sender: Any) {
        let vc = ARVC.createARVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ProfileViewController: UITableViewDelegate {
    
}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifiers[indexPath.row], for: indexPath) as? UserConfigurable else { return UITableViewCell() }
        
        if let headerCell = cell as? ProfileHeaderCell {
            headerCell.delegate = self
        }
        
        if let productCell = cell as? ProfileProductListCell {
            productCell.delegate = self
        }
        
        cell.configure(user: userService.getUser())
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return identifiers.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heights[indexPath.row]
    }
}

extension ProfileViewController: ProfileProductListCellDelegate {
    
    func didSelect(product: Product) {
        guard let vc = UserInterfaceService.storyboard(identifier: "ProductDetailsVC").instantiateInitialViewController() as? ProductDetailsVC else { return }
        vc.product = product
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController:  ProfileHeaderCellDelegate {
    
    func marketButtonDidTap() {
        let vc = UserInterfaceService.storyboard(identifier: "MarketVC").instantiateInitialViewController()!
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
