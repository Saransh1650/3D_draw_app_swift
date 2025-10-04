//
//  ARViewCntrollerWrapper.swift
//  drawing_app
//
//  Created by Saransh Singhal on 4/10/25.
//

import Foundation
import SwiftUI

struct ARViewControllerWrapper: UIViewControllerRepresentable {
    @Binding var drawingColor: Color
    
    func makeUIViewController(context: Context) -> ARDrawingViewController {
        let viewController = ARDrawingViewController()
        viewController.drawingColor = UIColor(drawingColor)
        return viewController
    }
    
    func updateUIViewController(
        _ uiViewController: ARDrawingViewController,
        context: Context
    ) {
        uiViewController.drawingColor = UIColor(drawingColor)
    }
}
