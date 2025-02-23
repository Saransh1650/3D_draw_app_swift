import UIKit
import ARKit

class ARDrawingViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {

    var sceneView: ARSCNView!
    var lastPosition: SCNVector3?
    var isDrawing = false
    var drawButton: UIButton!
    var pointerNode: SCNNode!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSceneView()
        setupARSession()
        setupUI()
    }

    func setupSceneView() {
        sceneView = ARSCNView(frame: view.bounds)
        sceneView.delegate = self
        sceneView.session.delegate = self
        sceneView.automaticallyUpdatesLighting = true
        sceneView.scene = SCNScene()
        view.addSubview(sceneView)

        setupPointer()
    }

    func setupARSession() {
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }

    func setupUI() {
        drawButton = UIButton(frame: CGRect(x: 20, y: view.frame.height - 500, width: 100, height: 50))
        drawButton.setTitle("Draw", for: .normal)
        drawButton.backgroundColor = .blue
        drawButton.addTarget(self, action: #selector(toggleDrawing), for: .touchUpInside)
        view.addSubview(drawButton)
    }

    @objc func toggleDrawing() {
        isDrawing.toggle()
        drawButton.setTitle(isDrawing ? "Stop" : "Draw", for: .normal)
        lastPosition = nil // Reset last position when starting new drawing
    }

    func setupPointer() {
        let sphere = SCNSphere(radius: 0.005) // Small red sphere
        sphere.firstMaterial?.diffuse.contents = UIColor.red

        pointerNode = SCNNode(geometry: sphere)
        sceneView.scene.rootNode.addChildNode(pointerNode)
    }

    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        let cameraTransform = frame.camera.transform
        let cameraPosition = SCNVector3(cameraTransform.columns.3.x,
                                        cameraTransform.columns.3.y,
                                        cameraTransform.columns.3.z)

        let forward = SCNVector3(-cameraTransform.columns.2.x,
                                 -cameraTransform.columns.2.y,
                                 -cameraTransform.columns.2.z)

        // Place pointer 30 cm in front of the camera
        let pointerDistance: Float = 0.3
        let pointerPosition = SCNVector3(
            cameraPosition.x + forward.x * pointerDistance,
            cameraPosition.y + forward.y * pointerDistance,
            cameraPosition.z + forward.z * pointerDistance
        )

        pointerNode.position = pointerPosition

        guard isDrawing else { return }

        if let lastPos = lastPosition {
            drawSmoothInterpolatedLine(from: lastPos, to: pointerPosition)
        }
        lastPosition = pointerPosition
    }

    func drawSmoothInterpolatedLine(from start: SCNVector3, to end: SCNVector3) {
        let distance = distanceBetween(start, end)
        let numSegments = max(Int(distance / 0.005), 1)

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
        cylinder.firstMaterial?.diffuse.contents = UIColor.white

        let node = SCNNode(geometry: cylinder)
        node.position = SCNVector3((start.x + end.x) / 2,
                                   (start.y + end.y) / 2,
                                   (start.z + end.z) / 2)

        return node
    }

    func distanceBetween(_ a: SCNVector3, _ b: SCNVector3) -> Float {
        return sqrt(pow(b.x - a.x, 2) + pow(b.y - a.y, 2) + pow(b.z - a.z, 2))
    }
}
