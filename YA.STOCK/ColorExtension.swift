//
//  ColorExtension.swift
//  YA.STOCK
//
//  Created by Яна Белкина on 20.03.2021.
//

import SwiftUI

public struct Colors {
    public static let primary:Color = Color(hexString:"#1A1A1A")
    public static let minor:Color = Color(hexString:"#BABABA")
    public static let invert:Color = Color(hexString:"#FFFFFF")
    public static let good:Color = Color(hexString:"#24B25D")
    public static let bad:Color = Color(hexString:"#B22424")
}

extension Color {
    init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        self.init(red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255)
    }
}



