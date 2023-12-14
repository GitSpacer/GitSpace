//
//  Color+.swift
//  GSUtilities
//
//  Created by 원태영 on 10/12/23.
//

import SwiftUI

// MARK: - Hexa Color
extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex >> 16) & 0xff) / 255
        let green = Double((hex >> 8) & 0xff) / 255
        let blue = Double((hex >> 0) & 0xff) / 255
        
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
    
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double((rgb >> 0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}

// MARK: - Custom Color Constant
public extension Color {
    static let gsGreenPrimary: Color = .init(hex: "#BDFF01")
    static let gsGreenSecondary: Color = .init(hex: "#E0FF66")
    static let gsYellow: Color = .init(hex: "#FAFF10")
    static let gsGray1: Color = .init(hex: "#8D8F97")
    static let gsGray2: Color = .init(hex: "#27292E")
    static let gsRed: Color = .init(hex: "#FF6C2E")
}
