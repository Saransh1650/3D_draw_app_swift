//
//  BrushEnums.swift
//  drawing_app
//
//  Created by Saransh Singhal on 16/2/25.
//


enum BrushEnums : String, Identifiable, CaseIterable {
    case pencil, marker, spray
    var id : String{ self.rawValue}
}

