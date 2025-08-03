<img src="https://github.com/user-attachments/assets/90bf44a1-f6bf-4ede-a91a-daadb29fd7c7" width="270" style="padding-right: 200px;"/>


<img src="https://github.com/user-attachments/assets/cadeaeb5-c2f6-4e47-a666-396b8d4e469d" width="270"/>



# 3D Drawing App

A SwiftUI-based drawing application for iOS and macOS, featuring both 2D and 3D drawing capabilities. This README focuses on the overall project and its 3D drawing features, excluding the 2D drawing functionality.

## Features

- **3D Drawing (AR):**
  - Draw in augmented reality using ARKit.
  - Save and manage 3D strokes and models.
  - Customizable brush types and colors for AR drawing.
  - Undo/redo support for AR strokes.
  - Dedicated toolbar for AR drawing controls.

- **Intro Screen:**
  - Welcome and onboarding experience for new users.

- **Core Utilities:**
  - Image saving utility for exporting drawings.
  - Undo manager for drawing actions.
  - Color extensions for enhanced color handling.

## Project Structure

```drawing_app/
├── App/
│   ├── AppRoutes.swift
│   └── DrawingApp.swift
├── Core/
│   ├── Extensions/
│   │   └── ColorExtensions.swift
│   └── Utils/
│       ├── ImageSaver.swift
│       └── UndoManager.swift
├── Features/
│   ├── Drawing3D/
│   │   ├── ARDrawingViewController.swift
│   │   ├── Model/
│   │   │   ├── ARDraingModel.swift
│   │   │   └── StorkeData.swift
│   │   ├── View/
│   │   │   ├── ARDrawingScreen.swift
│   │   │   ├── ARDrawingView.swift
│   │   │   └── ARToolBarView.swift
│   │   └── ViewModel/
│   │       ├── ARDrawingViewModel.swift
│   │       └── DrawingManager.swift
│   └── Into Screen/
│       └── View/
│           └── IntroPageView.swift
├── Resources/
│   └── Assets.xcassets/
├── drawing_appApp.swift
├── drawing_app.entitlements
└── drawing_app.xcodeproj/
```

## Getting Started

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Saransh1650/3D_draw_app_swift
   ```
2. **Open the project in Xcode:**
   - Double-click `drawing_app.xcodeproj`.
3. **Build and run:**
   - Select your target device (iOS or macOS).
   - Click the Run button in Xcode.

## 3D Drawing Feature Overview

- **ARDrawingViewController.swift:** Handles AR session and rendering.
- **ARDraingModel.swift & StorkeData.swift:** Data models for AR strokes and drawing data.
- **ARDrawingScreen.swift, ARDrawingView.swift, ARToolBarView.swift:** UI components for AR drawing.
- **ARDrawingViewModel.swift & DrawingManager.swift:** Business logic and state management for AR drawing.

## Utilities

- **ImageSaver.swift:** Save drawings to device storage.
- **UndoManager.swift:** Undo/redo functionality for drawing actions.
- **ColorExtensions.swift:** Helper extensions for color manipulation.

## Resources

- **Assets.xcassets:** Contains app icons and color assets.

## License

This project is licensed under the MIT License.
