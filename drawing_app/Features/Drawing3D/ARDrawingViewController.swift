//
//  ARDrawingViewController 2.swift
//  drawing_app
//
//  Created by Saransh Singhal on 22/2/25.
//


class ARDrawingViewController: UIViewController {
    var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup ARSCNView
        sceneView = ARSCNView(frame: view.frame)
        view.addSubview(sceneView)
        
        // Configure AR Session
        let config = ARWorldTrackingConfiguration()
        sceneView.session.run(config)
        
        // Add a default scene
        sceneView.scene = SCNScene()
    }
}
