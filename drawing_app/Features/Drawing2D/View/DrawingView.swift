//
//  DrawingView.swift
//  drawing_app
//
//  Created by Saransh Singhal on 11/02/25.
//

import SwiftUI

struct DrawingView: View {
    @StateObject var viewModel = DrawingViewModel()
    @State var lineWidth : CGFloat = 3.0
    @State var color : Color = .blue
    @State var brush : BrushEnums = .pencil
    var body: some View {
        VStack{
            ZStack{
                Color.white.edgesIgnoringSafeArea(.all)
                Canvas { context, size in
                    viewModel.stroke.forEach { stroke in
                        guard let first = stroke.points.first else { return }
                        var path = Path()
                        path.move(to: first)
                        stroke.points.dropFirst().forEach { path.addLine(to: $0) }
                        switch stroke.brushType {
                            
                        case .pencil:
                            context.stroke(path, with: .color(stroke.color), lineWidth: stroke.lineWidth)
                        case .spray:
                            stroke.points.forEach { point in
                                let sprayDensity = 20 // Number of dots per point
                                for _ in 0..<sprayDensity {
                                    let randomOffset = CGSize(width: CGFloat.random(in: -stroke.lineWidth...stroke.lineWidth),
                                                              height: CGFloat.random(in: -stroke.lineWidth...stroke.lineWidth))
                                    let dotPosition = CGPoint(x: point.x + randomOffset.width, y: point.y + randomOffset.height)
                                    let dotSize = stroke.lineWidth * 0.9 // Smaller dots for spray effect
                                    let dot = Path(ellipseIn: CGRect(x: dotPosition.x, y: dotPosition.y, width: dotSize, height: dotSize))
                                    context.fill(dot, with: .color(stroke.color.opacity(0.7)))
                                }}
                        case .dashedLine:
                            let dashedStyle = StrokeStyle(lineWidth: stroke.lineWidth, dash: [10, 5])
                            context.stroke(path, with: .color(stroke.color), style: dashedStyle)
                        case .paintBrush:
                            let brushStyle = StrokeStyle(lineWidth: stroke.lineWidth, lineCap: .round, lineJoin: .round)
                            context.stroke(path, with: .color(stroke.color.opacity(0.5)), style: brushStyle) // Slight transparency for soft look
                            
                        case .marker:
                            let markerStyle = StrokeStyle(lineWidth: stroke.lineWidth, lineCap: .square, lineJoin: .bevel)
                            context.stroke(path, with: .color(stroke.color), style: markerStyle)
                        }
                        
                    }
                    
                }
                
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in viewModel.addPoint(value.location, color: color, lineWidth: lineWidth, brushStyle: brush) }
                        .onEnded { _ in viewModel.endStroke() }
                )
            }
            ToolbarView(selectedBrush: $brush, lineWidth: $lineWidth, selectedColor: $color)
                .safeAreaPadding()
        }
        
        
    }
}

#Preview {
    DrawingView()
}
