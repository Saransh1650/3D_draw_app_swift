//
//  ColorPickerView.swift
//  drawing_app
//
//  Created by Saransh Singhal on 16/2/25.
//

import SwiftUI

struct ColorPickerView: View {
    @Binding var showColorPicker :Bool
    @Binding var selectedColor : Color
    var body: some View {
        VStack{
            ColorPicker(selection: $selectedColor){
                Text("Select Color")
                    .foregroundStyle(.black)
                
            }
                .frame(width: 200)
                .shadow(radius: 5)
                
            Button("Done"){
                showColorPicker = false
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(20)
        
    }
}

#Preview {
    @Previewable @State var showColorPciker : Bool = true
    @Previewable @State var selectedColor : Color = .blue
    ColorPickerView(showColorPicker: $showColorPciker, selectedColor: $selectedColor)
}
