//
//  StocksDetailsView.swift
//  YA.STOCK
//
//  Created by Яна Белкина on 18.03.2021.
//

import SwiftUI

struct StocksDetailsView: View {
    var stock: Stock
    var body: some View {
        VStack{
            Text(stock.ticker)
            Text(stock.companyName)
            Text(stock.price)
            Text(stock.diff).foregroundColor(Color.green)
        }
    }
}

private let stocksExample: [Stock] = [
    Stock(ticker: "AAPL", companyName: "Apple Inc.", price: "$131.93", diff: "+$0.12 (1,15%)", isFavorite: true, index: 0),
    
]
struct StocksDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        StocksDetailsView(stock: stocksExample[0])
    }
}
