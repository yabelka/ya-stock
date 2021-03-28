//
//  StockComanyName.swift
//  YA.STOCK
//
//  Created by Яна Белкина on 28.03.2021.
//

import SwiftUI

struct StockComanyName: View {
    var comanyName: String
    var body: some View {
        Text(comanyName)
            .font(.system(size: 11))
            .fontWeight(.semibold)
            .foregroundColor(Color.text_primary)
    }
}

struct StockComanyName_Previews: PreviewProvider {
    static var previews: some View {
        StockComanyName(comanyName: "Apple Inc.")
    }
}
