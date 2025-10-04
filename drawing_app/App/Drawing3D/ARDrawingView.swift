//
//  ARView.swift
//  drawing_app
//
//  Created by Saransh Singhal on 22/2/25.
//

import SwiftUI
import ARKit

struct ARDrawingView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ARDrawingViewController {
        return ARDrawingViewController()
    }
    
    func updateUIViewController(_ uiViewController: ARDrawingViewController, context: Context) {}
}

