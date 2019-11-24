//
//  JobsService.swift
//  ARKids
//
//  Created by Victor Sobolev on 25/09/2019.
//  Copyright © 2019 Victor Sobolev. All rights reserved.
//

import Foundation
import UIKit

struct Job {
    var title: String!
    var subtitle: String!
    var image: UIImage!
    var subImage: UIImage!
}

class JobsService {
    static func getJobs() -> [Job] {
        let gardener = Job(title: "Gardener", subtitle: "Selling buds", image: #imageLiteral(resourceName: "gardener"), subImage: #imageLiteral(resourceName: "leaf"))
        let mechanic = Job(title: "Mechanic", subtitle: "Fixing things", image: #imageLiteral(resourceName: "mechanic"), subImage: #imageLiteral(resourceName: "leaf"))
        let doctor = Job(title: "Doctor", subtitle: "Healing people", image: #imageLiteral(resourceName: "doctor"), subImage: #imageLiteral(resourceName: "leaf"))
        return [gardener, mechanic, doctor]
    }
}
