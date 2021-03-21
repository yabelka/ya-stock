//
//  MagnifierRect.swift
//  YA.STOCK
//
//  Created by Яна Белкина on 21.03.2021.
//

import SwiftUI

public struct MagnifierRect: View {
    @Binding var currentNumber: Double
    var valueSpecifier:String
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    public var body: some View {
        ZStack{
            if (self.colorScheme == .dark ){
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white, lineWidth: self.colorScheme == .dark ? 2 : 0)
                    .frame(width: 2, height: 250)
            }else{
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 2, height: 250)
                    .foregroundColor(Color.black)
//                    .shadow(color: Colors.LegendText, radius: 12, x: 0, y: 6 )
                    .blendMode(.multiply)
            }
        }
    }
}

