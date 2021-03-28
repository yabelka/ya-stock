//
//  MagnifierRect.swift
//  YA.STOCK
//
//  Created by Яна Белкина on 21.03.2021.
//

import SwiftUI

public struct MagnifierRect: View {
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
                    .blendMode(.multiply)
            }
        }
    }
}

