//
//  IndicatorPointv.swift
//  YA.STOCK
//
//  Created by Яна Белкина on 21.03.2021.
//

import SwiftUI

struct IndicatorPoint: View {
    var body: some View {
        ZStack{
            Circle()
                .fill(Color.black)
            Circle()
                .stroke(Color.white, style: StrokeStyle(lineWidth: 2))
        }
        .frame(width: 8, height: 8)
//        .shadow(color: Colors.LegendColor, radius: 6, x: 0, y: 6)
    }
}

struct IndicatorPoint_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorPoint()
    }
}
