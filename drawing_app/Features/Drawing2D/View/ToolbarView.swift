//
//  ToolbarView.swift
//  drawing_app
//
//  Created by Saransh Singhal on 11/02/25.
//

import SwiftUI

struct ToolbarView: View {
    @Binding var selectedBrush : BrushEnums
    @Binding var lineWidth : CGFloat
    @State var showColorPicker : Bool = false
    @Binding var selectedColor : Color
    @State private var popupPosition: CGPoint = .zero
    let colors: [Color] = [.white, .red, .blue, .green, .yellow]
    var body: some View {
        HStack{
            ForEach(BrushEnums.allCases, id: \.self) {brush in
                ZStack {
                    Circle()
                        .fill(selectedBrush == brush ? Color.blue : Color.gray.opacity(0.3)) // Highlight selected brush
                        .frame(width: 40, height: 40)
                        .onTapGesture {
                            selectedBrush = brush
                        }
                        .onLongPressGesture {
                            showColorPicker = true
                        }
                        .overlay(content: {
                            GeometryReader { GeometryProxy in
                                Color.clear
                                    .onAppear{
                                        popupPosition = GeometryProxy.frame(in: .global).origin
                                    }
                            }
                        })
                        .animation(.bouncy, value: selectedBrush)
                    
                    Image(systemName: brush.symbol) // Using SF Symbols
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                }
                
            }
            Slider(value: $lineWidth, in: 1...20)
        }
        .overlay {
            Group{
                if(showColorPicker){
                    ColorPickerView(showColorPicker: $showColorPicker, selectedColor: $selectedColor)
                        .position(x: popupPosition.x + 20, y: popupPosition.y + 50)
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var selectedColor : Color = .blue
    @Previewable @State var lineWidth : CGFloat = 10
    @Previewable @State var selectedBrush : BrushEnums = .pencil
    ToolbarView(selectedBrush: $selectedBrush, lineWidth: $lineWidth, selectedColor: $selectedColor)
}

