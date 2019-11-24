//
//  ProductDetailsVC.swift
//  ARKids
//
//  Created by Victor Sobolev on 25/09/2019.
//  Copyright © 2019 Victor Sobolev. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

class ProductDetailsVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sceneView: SCNView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var boostButton: UIView!
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        boostButton.layer.cornerRadius = 12
        tableView.contentInset = UIEdgeInsets(top: 350, left: 0, bottom: 0, right: 0)
        sceneView.backgroundColor = UIColor.clear
        reloadData()
        addSpin()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
        addSpin()
    }
    
    private func addSpin() {
        let spin = CABasicAnimation(keyPath: "rotation")
        NodeService.centerPivot(for: sceneView.scene!.rootNode)
        var position = SCNVector3(x: 0, y: 0, z: -1)
        if product.isBoosted {
            position = SCNVector3(x: 0, y: 0.5, z: -470)
        }
        let cameraNode = sceneView.pointOfView
        NodeService.updatePositionAndOrientationOf(sceneView.scene!.rootNode, withPosition: position, relativeTo: cameraNode!)
        spin.fromValue = NSValue(scnVector4: SCNVector4(x: 0, y: 0, z: 0, w: 0))
        spin.toValue = NSValue(scnVector4: SCNVector4(x: 0, y: 1, z: 0, w: Float(CGFloat(2 * Double.pi))))
        spin.duration = 5
        spin.repeatCount = .infinity
        sceneView.scene?.rootNode.addAnimation(spin, forKey: "spin around")
    }
    
    func reloadData() {
        let scene = SCNScene(named: product.modelScenePath)!
        product = ProductService.getProducts().last
        sceneView.scene = scene
        tableView.reloadData()
        titleLabel.text = product.title
    }
    
    static func getProductDetailsVC() -> ProductDetailsVC {
        let vc = UserInterfaceService.viewControllerFromStoryboard(identifier: "ProductDetailsVC", storyboardIdentifier: "ProductDetailsVC") as! ProductDetailsVC
        return vc
    }
    
    @IBAction func didTapBoostButton(_ sender: Any) {
        //TODO: Go to map
        let vc = UserInterfaceService.viewControllerFromStoryboard(identifier: "MapViewController", storyboardIdentifier: "MapViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProductDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product.skills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let skill = product.skills[indexPath.row]
        let cell = ProgressCell.createCell(progressPercent: skill.currentLevel, colorLeft: #colorLiteral(red: 0.3568627451, green: 0.4588235294, blue: 0.9137254902, alpha: 1), colorRight: #colorLiteral(red: 0.4117647059, green: 0.6352941176, blue: 0.9725490196, alpha: 1))
        cell.titleView.text = skill.name
        cell.imageView?.image = skill.image
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

class ProgressCell: UITableViewCell {
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var progressView: UIView!
    var progressPercent: Int!
    var colorLeft: UIColor!
    var colorRight: UIColor!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        selectionStyle = .none
    }
    
    func addProgress() {
        ProgressView.addToView(progressView, progressPercent: progressPercent, colorLeft: colorLeft, colorRight: colorRight)
    }
    
    static func createCell(progressPercent: Int, colorLeft: UIColor, colorRight: UIColor) -> ProgressCell {
        let cell = UserInterfaceService.viewFromMainBundle(identifier: "ProgressCell") as! ProgressCell
        cell.progressPercent = progressPercent
        cell.colorLeft = colorLeft
        cell.colorRight = colorRight
        cell.addProgress()
        return cell
    }
}
