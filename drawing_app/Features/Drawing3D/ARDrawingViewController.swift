import UIKit
import SwiftUI
import ARKit

class ARDrawingViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    var drawingColor : UIColor = .blue
    var sceneView: ARSCNView!
    var lastPosition: SCNVector3?
    var isDrawing = false
    var pointerNode: SCNNode!
   

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSceneView()
        setupARSession()
        setupPointer()
        setupObservers()
        print("inti")
    }

    func setupSceneView() {
        sceneView = ARSCNView(frame: view.bounds)
        sceneView.delegate = self
        sceneView.session.delegate = self
        sceneView.automaticallyUpdatesLighting = true
        sceneView.scene = SCNScene()
        view.addSubview(sceneView)
    }

    func setupARSession() {
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])

    }

    func setupPointer() {
        pointerNode = SCNNode(geometry: SCNSphere(radius: 0.005))
        pointerNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        sceneView.scene.rootNode.addChildNode(pointerNode)
    }

    func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(toggleDrawing(_:)), name: NSNotification.Name("ToggleDrawing"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeColor(_:)), name: NSNotification.Name("ColorChanged"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(exportDrawingAs3D), name: NSNotification.Name("Export3D"), object: nil)


    }

    @objc func toggleDrawing(_ notification: Notification) {
        if let state = notification.object as? Bool {
            isDrawing = state
            lastPosition = nil
        }
    }
    @objc func changeColor(_ notification: Notification) {
           if let newColor = notification.object as? UIColor {
               drawingColor = newColor
               print("Changed color to: \(drawingColor)")
           }
       }
    @objc func exportDrawingAs3D() {
        let fileURL = saveSceneToUSDZ()

        let activityVC = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view

        DispatchQueue.main.async {
            self.present(activityVC, animated: true, completion: nil)
        }
    }

    /// Saves the 3D scene to a `.usdz` file and returns the file URL
    func saveSceneToUSDZ() -> URL {
        let scene = SCNScene()

        // Copy all drawn nodes into the new scene
        for node in sceneView.scene.rootNode.childNodes {
            let clonedNode = node.clone()
            scene.rootNode.addChildNode(clonedNode)
        }

        let fileName = "AR_Drawing.usdz"
        let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
            scene.write(to: fileURL, options: nil, delegate: nil)
            print("✅ Exported to: \(fileURL)")
            return fileURL
    }

    



    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        updatePointerPosition()

        guard isDrawing else { return }

        let pointerPosition = pointerNode.position
        if let lastPos = lastPosition {
            drawSmoothInterpolatedLine(from: lastPos, to: pointerPosition)
        }
        lastPosition = pointerPosition
    }

    func updatePointerPosition() {
        guard let frame = sceneView.session.currentFrame else { return }
        let cameraTransform = frame.camera.transform
        let cameraPosition = SCNVector3(cameraTransform.columns.3.x,
                                        cameraTransform.columns.3.y,
                                        cameraTransform.columns.3.z)

        let forwardVector = SCNVector3(-cameraTransform.columns.2.x,
                                       -cameraTransform.columns.2.y,
                                       -cameraTransform.columns.2.z)

        let pointerPosition = SCNVector3(cameraPosition.x + forwardVector.x * 0.3,
                                         cameraPosition.y + forwardVector.y * 0.3,
                                         cameraPosition.z + forwardVector.z * 0.3)

        pointerNode.position = pointerPosition
    }

    func drawSmoothInterpolatedLine(from start: SCNVector3, to end: SCNVector3) {
        let distance = distanceBetween(start, end)
        let numSegments = max(Int(distance / 0.001), 1)

        for i in 1...numSegments {
            let t = Float(i) / Float(numSegments)
            let interpolated = SCNVector3(
                start.x + (end.x - start.x) * t,
                start.y + (end.y - start.y) * t,
                start.z + (end.z - start.z) * t
            )

            let strokeSegment = createSmoothStroke(from: lastPosition ?? interpolated, to: interpolated)
            sceneView.scene.rootNode.addChildNode(strokeSegment)
            lastPosition = interpolated
        }
    }

    func createSmoothStroke(from start: SCNVector3, to end: SCNVector3) -> SCNNode {
        let radius: CGFloat = 0.002
        let height = CGFloat(distanceBetween(start, end))
        guard height > 0 else { return SCNNode() }

        let cylinder = SCNCylinder(radius: radius, height: height)
        cylinder.firstMaterial?.diffuse.contents = drawingColor

        let node = SCNNode(geometry: cylinder)
        node.position = SCNVector3((start.x + end.x) / 2,
                                   (start.y + end.y) / 2,
                                   (start.z + end.z) / 2)
        node.look(at: end, up: sceneView.scene.rootNode.worldUp, localFront: node.worldUp)

        return node
    }

    func distanceBetween(_ a: SCNVector3, _ b: SCNVector3) -> Float {
        return sqrt(pow(b.x - a.x, 2) + pow(b.y - a.y, 2) + pow(b.z - a.z, 2))
    }
}
