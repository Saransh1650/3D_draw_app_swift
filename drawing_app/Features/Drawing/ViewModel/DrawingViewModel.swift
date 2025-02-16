//
//  DrawingViewModel.swift
//  drawing_app
//
//  Created by Saransh Singhal on 11/02/25.
//

import SwiftUI

class DrawingViewModel : ObservableObject{
    @Published var stroke : [StrokeModel] = []
    private var currentStroke = StrokeModel()
    
    func addPoint(_ point: CGPoint, color: Color, lineWidth: CGFloat) {
        if stroke.isEmpty || stroke.last?.isFinished == true {
                   stroke.append(StrokeModel(points: [point], color: color, lineWidth: lineWidth))
               } else {
                   stroke[stroke.count - 1].points.append(point)
               }
       }

       func endStroke() {
           guard !stroke.isEmpty else { return }  // ✅ Prevents crash
              stroke[stroke.count - 1].isFinished = true
       }
}
