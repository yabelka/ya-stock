//
//  StockPrice.swift
//  YA.STOCK
//
//  Created by Яна Белкина on 28.03.2021.
//

import SwiftUI

struct StockPrice: View {
    var price: Double

    var body: some View {
        let formatedPrice = round(self.price * 100) / 100
        let currencySymbol = "$"

        Text(String("\(currencySymbol)\(formatedPrice)"))
            .font(.system(size: 18))
            .fontWeight(.bold)
            .foregroundColor(Colors.text_primary)
    }
}

struct StockPrice_Previews: PreviewProvider {
    static var previews: some View {
        StockPrice(price: 33.3333)
    }
}
