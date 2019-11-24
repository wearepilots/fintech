//
//  ProgressView.swift
//  ARKids
//
//  Created by Victor Sobolev on 25/09/2019.
//  Copyright © 2019 Victor Sobolev. All rights reserved.
//

import Foundation
import UIKit

class ProgressView: UIView {
    var progressPercent: Int!
    var colorLeft: UIColor!
    var colorRight: UIColor!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var progressView: UIView!
    var parentView: UIView?
    var gradient: CAGradientLayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        reloadProgress()
    }
    
    private func reloadProgress() {
        guard let backView = backView else { return }
        if let parent = parentView {
            frame = parent.bounds
        }
        backView.layer.cornerRadius = frame.height/2
        progressView.frame = CGRect(x: frame.origin.x,
                                    y: frame.origin.y,
                                    width: frame.width/100*CGFloat(progressPercent),
                                    height: frame.height)
        progressView.layer.cornerRadius = frame.height/2

        if gradient == nil {
            let gradient: CAGradientLayer = CAGradientLayer()

            gradient.colors = [colorLeft.cgColor, colorRight.cgColor]
            gradient.locations = [0.0, 1.0]
            gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradient.frame = CGRect(x: 0.0, y: 0.0, width: progressView.frame.size.width, height: progressView.frame.size.height)

            progressView.layer.insertSublayer(gradient, at: 0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


extension ProgressView {
    static func addToView(_ view: UIView, progressPercent: Int, colorLeft: UIColor, colorRight: UIColor) {
        let newView = createProgressView(progressPercent: progressPercent, colorLeft: colorLeft, colorRight: colorRight)
        newView.frame = view.bounds
        newView.parentView = view
        view.addSubview(newView)
    }
    
    static func createProgressView(progressPercent: Int, colorLeft: UIColor, colorRight: UIColor) -> ProgressView {
        let view = UserInterfaceService.viewFromMainBundle(identifier: "ProgressView") as! ProgressView
        view.progressPercent = progressPercent
        view.colorLeft = colorLeft
        view.colorRight = colorRight
        return view
    }
}
