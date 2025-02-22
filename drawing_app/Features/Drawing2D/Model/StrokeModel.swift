//
//  StrokeModel.swift
//  drawing_app
//
//  Created by Saransh Singhal on 11/02/25.
//

import Foundation
import SwiftUI

struct StrokeModel: Identifiable{
    let id = UUID()
    var points: [CGPoint] = []
    var color:
    Color = .blue
    
    
    var lineWidth: CGFloat = 10
    var isFinished: Bool = false
    var brushType : BrushEnums = .pencil
    
}
