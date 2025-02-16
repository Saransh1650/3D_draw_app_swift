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
    var body: some View {
        VStack{
            ZStack{
                Color.white.edgesIgnoringSafeArea(.all)
                Canvas{
                    context, size in
                    for stroke in viewModel.stroke {
                        var path = Path()
                        if let first = stroke.points.first {
                            path.move(to: first)
                            for point in stroke.points.dropFirst() {
                                path.addLine(to: point)
                            }
                        }
                        context.stroke(path, with: .color(stroke.color), lineWidth: stroke.lineWidth)
                    }
                }
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in viewModel.addPoint(value.location, color: color, lineWidth: lineWidth) }
                        .onEnded { _ in viewModel.endStroke() }
                )
            }
            ToolbarView(selectedColor: $color, lineWidth: $lineWidth)
                .safeAreaPadding()
        }
        
        
    }
}

#Preview {
    DrawingView()
}
