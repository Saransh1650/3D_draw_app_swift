//
//  BrushEnums.swift
//  drawing_app
//
//  Created by Saransh Singhal on 16/2/25.
//


enum BrushEnums : String, Identifiable, CaseIterable {
    case pencil, marker, spray, dashedLine, paintBrush
    var id : String{ self.rawValue}
    var symbol : String{
        switch self {
        case .pencil: return "pencil.tip"
        case .marker: return "highlighter"
        case .spray: return "sparkles"
        case .dashedLine: return "scribble"
        case .paintBrush: return "paintbrush.fill"
        }
    }
    
    
    
}

