//
//  ViewController.swift
//  ARKids
//
//  Created by Victor Sobolev on 25/09/2019.
//  Copyright © 2019 Victor Sobolev. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ARVC: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet var boostButton: UIButton!
    private var planeNode: SCNNode?
    private var imageNode: SCNNode?
    private var animationInfo: AnimationInfo?
    
    var oldBikeScene: SCNScene!
    var oldBikeNode: SCNNode!
    var newBikeScene: SCNScene!
    var newBikeNode: SCNNode!
    var currentBike: SCNNode!
    var bikes = [SCNNode]()
    var bikeLastPosition: simd_float3!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene()
        oldBikeScene = SCNScene(named: "art.scnassets/woodenBike.scn")!
        oldBikeNode = oldBikeScene.rootNode.childNode(withName: "woodenBike", recursively: true)!
        newBikeScene = SCNScene(named: "art.scnassets/coolBike.scn")!
        newBikeNode = newBikeScene.rootNode.childNode(withName: "coolBike", recursively: true)!
        currentBike = oldBikeNode
        NodeService.centerPivot(for: newBikeNode)
        NodeService.centerPivot(for: oldBikeNode)
        bikes = [oldBikeNode, newBikeNode]
        newBikeNode.opacity = 0
        sceneView.scene = scene
        sceneView.delegate = self
        boostButton.layer.cornerRadius = 12
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Load reference images to look for from "AR Resources" folder
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
            fatalError("Missing expected asset catalog resources.")
        }
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Add previously loaded images to ARScene configuration as detectionImages
        configuration.detectionImages = referenceImages
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else {
            return
        }
        DispatchQueue.main.async {
            self.boostButton.isHidden = false
        }
        for bike in bikes {
        // 2. Calculate size based on planeNode's bounding box.
        let (min, max) = bike.boundingBox
        let size = SCNVector3Make(max.x - min.x, max.y - min.y, max.z - min.z)
        
        // 3. Calculate the ratio of difference between real image and object size.
        // Ignore Y axis because it will be pointed out of the image.
        let widthRatio = Float(imageAnchor.referenceImage.physicalSize.width)/size.x
        let heightRatio = Float(imageAnchor.referenceImage.physicalSize.height)/size.z

        // Pick smallest value to be sure that object fits into the image.
        let finalRatio = [widthRatio, heightRatio].min()!
        
        // 4. Set transform from imageAnchor data.
        bike.transform = SCNMatrix4(imageAnchor.transform)
        
        // 5. Animate appearance by scaling model from 0 to previously calculated value.
        let appearanceAction = SCNAction.scale(to: CGFloat(finalRatio), duration: 0.4)
        appearanceAction.timingMode = .easeOut
        // Set initial scale to 0.
        bike.scale = SCNVector3Make(0.001, 0.001, 0.001)
        // Add to root node.
        //node.addChildNode(bike)
        sceneView.scene.rootNode.addChildNode(bike)
        // Run the appearance animation.
        bike.runAction(appearanceAction)
        
        self.imageNode = node
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        guard let imageNode = imageNode else {
            return
        }
        for bike in bikes {
        // 1. Unwrap animationInfo. Calculate animationInfo if it is nil.
        guard let animationInfo = animationInfo else {
            bikeLastPosition = imageNode.simdWorldPosition
            refreshAnimationVariables(startTime: time,
                                      initialPosition: bike.simdWorldPosition,
                                      finalPosition: imageNode.simdWorldPosition,
                                      initialOrientation: bike.simdWorldOrientation,
                                      finalOrientation: imageNode.simdWorldOrientation)
            return
        }
        
        // 2. Calculate new animationInfo if image position or orientation changed.
        if !simd_equal(animationInfo.finalModelPosition, imageNode.simdWorldPosition) || animationInfo.finalModelOrientation != imageNode.simdWorldOrientation {
            refreshAnimationVariables(startTime: time,
                                      initialPosition: bikeLastPosition,
                                      finalPosition: imageNode.simdWorldPosition,
                                      initialOrientation: bike.simdWorldOrientation,
                                      finalOrientation: imageNode.simdWorldOrientation)
            bikeLastPosition = imageNode.simdWorldPosition
        }
        
        // 3. Calculate interpolation based on passedTime/totalTime ratio.
        let passedTime = time - animationInfo.startTime
        var t = min(Float(passedTime/animationInfo.duration), 1)
        // Applying curve function to time parameter to achieve "ease out" timing
        t = sin(t * .pi * 0.5)
        
        // 4. Calculate and set new model position and orientation.
        let f3t = simd_make_float3(t, t, t)
        bike.simdWorldPosition = simd_mix(animationInfo.initialModelPosition, animationInfo.finalModelPosition, f3t)
        bike.simdWorldOrientation = simd_slerp(animationInfo.initialModelOrientation, animationInfo.finalModelOrientation, t)
        bike.simdWorldOrientation = imageNode.simdWorldOrientation
        }
    }
    
    func refreshAnimationVariables(startTime: TimeInterval, initialPosition: float3, finalPosition: float3, initialOrientation: simd_quatf, finalOrientation: simd_quatf) {
        let distance = simd_distance(initialPosition, finalPosition)
        // Average speed of movement is 0.15 m/s.
        let speed = Float(0.15)
        // Total time is calculated as distance/speed. Min time is set to 0.1s and max is set to 2s.
        let animationDuration = Double(0.15)
        // Store animation information for later usage.
        animationInfo = AnimationInfo(startTime: startTime,
                                      duration: animationDuration,
                                      initialModelPosition: initialPosition,
                                      finalModelPosition: finalPosition,
                                      initialModelOrientation: initialOrientation,
                                      finalModelOrientation: finalOrientation)
    }
    
    @IBAction func tapOnBoost(_ sender: Any) {
        currentBike = newBikeNode
        
        let appearanceAction = SCNAction.fadeIn(duration: 1.0)
        appearanceAction.timingMode = .easeOut
        // Add to root node.
        sceneView.scene.rootNode.addChildNode(currentBike)
        // Run the appearance animation.
        currentBike.runAction(appearanceAction)
        
        let disappearAction = SCNAction.fadeOut(duration: 1.0)
        appearanceAction.timingMode = .easeOut
        // Run the appearance animation.
        oldBikeNode.runAction(disappearAction)
    }
}

extension ARVC {
    static func createARVC() -> ARVC {
        let vc = UserInterfaceService.viewControllerFromStoryboard(identifier: "ARVC", storyboardIdentifier: "ARVC") as! ARVC
        return vc
    }
}


struct AnimationInfo {
    var startTime: TimeInterval
    var duration: TimeInterval
    var initialModelPosition: simd_float3
    var finalModelPosition: simd_float3
    var initialModelOrientation: simd_quatf
    var finalModelOrientation: simd_quatf
}

