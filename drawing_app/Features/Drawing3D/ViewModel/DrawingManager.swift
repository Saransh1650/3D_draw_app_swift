//
//  DrawingManager.swift
//  drawing_app
//
//  Created by Saransh Singhal on 23/2/25.
////
//
//import Foundation
//import ARKit
//class DrawingManager {
//    private weak var sceneView: ARSCNView?
//    private var lastPosition: SCNVector3?
//    
//    init(sceneView: ARSCNView) {
//        self.sceneView = sceneView
//    }
//    
//    func addStroke(to position: SCNVector3) {
//        guard let lastPos = lastPosition else {
//            lastPosition = position
//            return
//        }
//        
//        drawSmoothInterpolatedLine(from: lastPos, to: position)
//        lastPosition = position
//    }
//    
//    private func drawSmoothInterpolatedLine(from start: SCNVector3, to end: SCNVector3) {
//        let distance = distanceBetween(start, end)
//        let numSegments = max(Int(distance / 0.001), 1)
//        
//        for i in 1...numSegments {
//            let t = Float(i) / Float(numSegments)
//            let interpolated = SCNVector3(
//                start.x + (end.x - start.x) * t,
//                start.y + (end.y - start.y) * t,
//                start.z + (end.z - start.z) * t
//            )
//            
//            let strokeSegment = createSmoothStroke(from: lastPosition ?? interpolated, to: interpolated)
//            sceneView?.scene.rootNode.addChildNode(strokeSegment)
//            lastPosition = interpolated
//        }
//    }
//    
//    private func createSmoothStroke(from start: SCNVector3, to end: SCNVector3) -> SCNNode {
//        let radius: CGFloat = 0.002
//        let height = CGFloat(distanceBetween(start, end))
//        guard height > 0 else { return SCNNode() }
//        
//        let cylinder = SCNCylinder(radius: radius, height: height)
//        cylinder.firstMaterial?.diffuse.contents = UIColor.white
//        
//        let node = SCNNode(geometry: cylinder)
//        node.position = SCNVector3((start.x + end.x) / 2,
//                                   (start.y + end.y) / 2,
//                                   (start.z + end.z) / 2)
//        node.look(at: end, up: sceneView?.scene.rootNode.worldUp ?? SCNVector3(0, 1, 0), localFront: node.worldUp)
//        
//        return node
//    }
//    
//    private func distanceBetween(_ a: SCNVector3, _ b: SCNVector3) -> Float {
//        return sqrt(pow(b.x - a.x, 2) + pow(b.y - a.y, 2) + pow(b.z - a.z, 2))
//    }
//}
