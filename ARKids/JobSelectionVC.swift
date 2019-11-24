//
//  JobSelectionVC.swift
//  ARKids
//
//  Created by Victor Sobolev on 25/09/2019.
//  Copyright © 2019 Victor Sobolev. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setupTransparentNavBar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        
        navigationController?.navigationBar.barStyle = .black
    }
}

class JobSelectionVC: UIViewController {
    private var jobsData = [Job]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 85, left: 0, bottom: 0, right: 0)
        loadData()
        
        setupTransparentNavBar()
    }
    
    private func loadData() {
        jobsData = JobsService.getJobs()
        tableView.reloadData()
    }
    
    static func getJobSelectionVC() -> JobSelectionVC {
        let vc = UserInterfaceService.viewControllerFromStoryboard(identifier: "JobSelectionVC", storyboardIdentifier: "JobSelectionVC") as! JobSelectionVC
        return vc
    }
}

extension JobSelectionVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return JobCell.getJobCell(jobsData[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserService.job = jobsData[indexPath.row]
        guard let vc = UserInterfaceService.storyboard(identifier: "ProfileVC").instantiateInitialViewController() else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}

class JobCell: UITableViewCell {
    @IBOutlet weak var bigImageView: UIImageView!
    @IBOutlet weak var smallImageView: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = UIColor.clear
        backView.layer.cornerRadius = 15
    }
    
    static func getJobCell(_ job: Job) -> JobCell {
        let cell = UserInterfaceService.viewFromMainBundle(identifier: "JobCell") as! JobCell
        cell.bigImageView.image = job.image
        cell.smallImageView.image = job.subImage
        cell.titleLabel.text = job.title
        cell.subtitleLabel.text = job.subtitle
        return cell
    }
}
