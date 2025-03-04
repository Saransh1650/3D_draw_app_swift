//
//  IntroPageView.swift
//  drawing_app
//
//  Created by Saransh Singhal on 3/3/25.
//

import SwiftUI

struct IntroPageView: View {
    var body: some View {
        VStack
        {
            Button("3D Drawing") {
                
            }
            .padding()
            .background(Color.blue)
            .foregroundStyle(.white)
            .cornerRadius(20)
            .bold()
            .shadow(radius: 5)
            
            Button("2D Drawing"){
                
            }
        }
        
        
    }
}

#Preview {
    IntroPageView()
}
