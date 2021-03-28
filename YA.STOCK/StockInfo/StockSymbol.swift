//
//  StockSymbol.swift
//  YA.STOCK
//
//  Created by Яна Белкина on 28.03.2021.
//

import SwiftUI

struct StockSymbol: View {
    var symbol: String
    var body: some View {
        Text(symbol)
            .font(.system(size: 18))
            .fontWeight(.bold)
            .foregroundColor(Color.text_primary)
    }
}

struct StockSymbol_Previews: PreviewProvider {
    static var previews: some View {
        StockSymbol(symbol: "AAPL")
    }
}
