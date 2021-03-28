//
//  StockChanges.swift
//  YA.STOCK
//
//  Created by Яна Белкина on 28.03.2021.
//

import SwiftUI

struct StockChanges: View {
    var priceChange: Double
    var percentChande: Double
    
    var body: some View {
        let priceChange = round(self.priceChange * 100) / 100
        let percentChange = round(percentChande * 100) / 100
        
        let changePriceSymbol = priceChange == 0 ? "" : priceChange > 0 ? "+" : "-"
        let changePriceColor = priceChange == 0 ? Color.text_minor : priceChange > 0 ? Color.text_good : Color.text_bad
        let currencySymbol = "$"

        Text("\(changePriceSymbol)\(currencySymbol)\(String(abs(priceChange))) (\(String(abs(percentChange)))%)")
            .font(.system(size: 12))
            .fontWeight(.semibold)
            .foregroundColor(changePriceColor)
    }
}

struct StockChanges_Previews: PreviewProvider {
    static var previews: some View {
        StockChanges(priceChange: 22.17, percentChande: 5.15)
    }
}
