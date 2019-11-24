//
//  UserInterfaceService.swift
//  RenCredit
//
//  Created by Victor Sobolev on 25/04/2019.
//  Copyright © 2019 BSC Msc. All rights reserved.
//

import Foundation
import UIKit

class UserInterfaceService: NSObject {

    static func storyboard(identifier: String) -> UIStoryboard {
        let storyboard = UIStoryboard(name: identifier, bundle: Bundle(for: self))
        return storyboard
    }

    /// Returns viewcontroller from main storyboard
    ///
    /// - Parameter identifier: string identifier
    /// - Returns: viewcontroller
    static func viewControllerFromStoryboard<T: UIViewController>(identifier: String, storyboardIdentifier: String) -> T {
        let storyboard = UserInterfaceService.storyboard(identifier: storyboardIdentifier)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        return viewController as! T
    }

    /// Returns view from main bundle
    ///
    /// - Parameter identifier: string identifier
    /// - Returns: view
    static func viewFromMainBundle<T: UIView>(identifier: String) -> T? {
        let bundle = Bundle.init(for: self)
        let view = bundle.loadNibNamed(identifier, owner: T(), options: nil)?.first
        return view as? T
    }

    static func addBottomConstraintsTo(view1: UIView!, view2: UIView!, offset: CGFloat, height: CGFloat) {

        let heightConstraint = NSLayoutConstraint(item: view1,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1,
                                                  constant: height)

        let leftConstraint = NSLayoutConstraint(item: view1,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: view2,
                                                attribute: .left,
                                                multiplier: 1,
                                                constant: offset)

        let rightConstraint = NSLayoutConstraint(item: view1,
                                                 attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: view2,
                                                 attribute: .right,
                                                 multiplier: 1,
                                                 constant: -offset)

        let bottomConstraint = NSLayoutConstraint(item: view1,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: view2,
                                                  attribute: .bottom,
                                                  multiplier: 1,
                                                  constant: -offset)

        view2.addConstraints([leftConstraint, rightConstraint, bottomConstraint, heightConstraint])
    }

    static func addZeroConstraintsTo(view1: UIView!, view2: UIView!) {

        let topConstraint = NSLayoutConstraint(item: view1,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: view2,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: 0)

        let leftConstraint = NSLayoutConstraint(item: view1,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: view2,
                                                attribute: .left,
                                                multiplier: 1,
                                                constant: 0)

        let rightConstraint = NSLayoutConstraint(item: view1,
                                                 attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: view2,
                                                 attribute: .right,
                                                 multiplier: 1,
                                                 constant: 0)

        let bottomConstraint = NSLayoutConstraint(item: view1,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: view2,
                                                  attribute: .bottom,
                                                  multiplier: 1,
                                                  constant: 0)

        view2.addConstraints([leftConstraint, rightConstraint, bottomConstraint, topConstraint])
    }

    static func addCenteredConstraintsTo(view1: UIView!, view2: UIView!, width: CGFloat, height: CGFloat) {

        let centerX = NSLayoutConstraint(item: view1, attribute: .centerX, relatedBy: .equal, toItem: view2, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: view1, attribute: .centerY, relatedBy: .equal, toItem: view2, attribute: .centerY, multiplier: 1, constant: 0)

        let widthConstraint = NSLayoutConstraint(item: view1,
                                                  attribute: .width,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1,
                                                  constant: width)

        let heightConstraint = NSLayoutConstraint(item: view1,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1,
                                                  constant: height)

        view2.addConstraints([centerX, centerY, widthConstraint, heightConstraint])
    }

    static func addAndGetBottomConstraintsTo(view1: UIView!, view2: UIView!, offset: CGFloat, height: CGFloat) -> NSLayoutConstraint {

        let heightConstraint = NSLayoutConstraint(item: view1,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1,
                                                  constant: height)

        let leftConstraint = NSLayoutConstraint(item: view1,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: view2,
                                                attribute: .left,
                                                multiplier: 1,
                                                constant: offset)

        let rightConstraint = NSLayoutConstraint(item: view1,
                                                 attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: view2,
                                                 attribute: .right,
                                                 multiplier: 1,
                                                 constant: -offset)

        let bottomConstraint = NSLayoutConstraint(item: view1,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: view2,
                                                  attribute: .bottom,
                                                  multiplier: 1,
                                                  constant: -offset)

        view2.addConstraints([leftConstraint, rightConstraint, bottomConstraint, heightConstraint])

        return bottomConstraint
    }

    static func addTopConstraintsTo(view1: UIView!, topView: UIView!, inView: UIView!, offset: CGFloat, height: CGFloat, toTop: Bool) {

        let heightConstraint = NSLayoutConstraint(item: view1,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1,
                                                  constant: height)

        let leftConstraint = NSLayoutConstraint(item: view1,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: inView,
                                                attribute: .left,
                                                multiplier: 1,
                                                constant: offset)

        let rightConstraint = NSLayoutConstraint(item: view1,
                                                 attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: inView,
                                                 attribute: .right,
                                                 multiplier: 1,
                                                 constant: -offset)

        let topConstraint = NSLayoutConstraint(item: view1,
                                                  attribute: .top,
                                                  relatedBy: .equal,
                                                  toItem: topView,
                                                  attribute: toTop ? .top : .bottom,
                                                  multiplier: 1,
                                                  constant: offset)

        inView.addConstraints([leftConstraint, rightConstraint, heightConstraint, topConstraint])
    }

    static func addAndGetTopConstraintsTo(view1: UIView!, view2: UIView!, offset: CGFloat, topOffset: CGFloat, height: CGFloat) -> NSLayoutConstraint {

        let heightConstraint = NSLayoutConstraint(item: view1,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1,
                                                  constant: height)

        let leftConstraint = NSLayoutConstraint(item: view1,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: view2,
                                                attribute: .left,
                                                multiplier: 1,
                                                constant: offset)

        let rightConstraint = NSLayoutConstraint(item: view1,
                                                 attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: view2,
                                                 attribute: .right,
                                                 multiplier: 1,
                                                 constant: -offset)

        let topConstraint = NSLayoutConstraint(item: view1,
                                                  attribute: .top,
                                                  relatedBy: .equal,
                                                  toItem: view2,
                                                  attribute: .top,
                                                  multiplier: 1,
                                                  constant: -topOffset)

        view2.addConstraints([leftConstraint, rightConstraint, topConstraint, heightConstraint])

        return topConstraint
    }

    static func showAlertWith(title: String, message: String) {
        let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
}
