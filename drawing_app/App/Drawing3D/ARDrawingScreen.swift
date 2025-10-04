import SwiftUI

struct ARDrawingScreen: View {
    @State private var isDrawing = false
    @State private var selectedColor: Color = .blue

    var body: some View {
        ZStack {
            ARViewControllerWrapper(drawingColor: $selectedColor)
                .edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        NotificationCenter.default.post(
                            name: NSNotification.Name("Export3D"),
                            object: nil
                        )
                    }) {
                        Image(systemName: "square.and.arrow.up")

                            .padding()
                            .cornerRadius(10)
                    }
                    .padding()
                }
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        isDrawing.toggle()
                        NotificationCenter.default.post(
                            name: NSNotification.Name("ToggleDrawing"),
                            object: isDrawing
                        )
                    }) {
                        Text(isDrawing ? "Stop Drawing" : "Start Drawing")
                            .padding()
                            .background(isDrawing ? Color.red : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding()
                    
                    Spacer()
                    
                    ColorPicker(
                        "",
                        selection: $selectedColor,
                        supportsOpacity: true
                    )
                    .labelsHidden()
                    .padding()
                    .onChange(of: selectedColor, initial: true) {
                        newColor,
                        arg in
                        NotificationCenter.default.post(
                            name: NSNotification.Name("ColorChanged"),
                            object: UIColor(newColor)
                        )
                    }

                }
            }
            .padding(.bottom, 30)
        }
    }
}


