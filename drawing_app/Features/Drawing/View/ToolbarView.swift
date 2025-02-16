//
//  ToolbarView.swift
//  drawing_app
//
//  Created by Saransh Singhal on 11/02/25.
//

import SwiftUI

struct ToolbarView: View {
    @Binding var selectedColor : Color
    @Binding var lineWidth : CGFloat
    
    let colors: [Color] = [.white, .red, .blue, .green, .yellow]
    var body: some View {
        HStack{
            ForEach(colors, id: \.self) {color in
                Circle()
                    .fill(color)
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        selectedColor = color
                    }
                    .overlay {
                        Circle()
                            .stroke(selectedColor == color ? Color.black : Color.white, lineWidth: 3)
                            .animation(.bouncy, value: selectedColor)
                                
                            
                    }
                    
                   
            }
            Slider(value: $lineWidth, in: 1...10)
        }
    }
}

#Preview {
    @Previewable @State var selectedColor : Color = .blue
    @Previewable @State var lineWidth : CGFloat = 10
    ToolbarView(selectedColor: $selectedColor, lineWidth: $lineWidth)
}

