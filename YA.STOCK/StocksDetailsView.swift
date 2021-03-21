//
//  StocksDetailsView.swift
//  YA.STOCK
//
//  Created by Яна Белкина on 18.03.2021.
//

import SwiftUI

struct StocksDetailsView: View {
    var stock: Quotes
    var body: some View {
        VStack{
            Text(stock.symbol)
            Text(stock.longName)
            LineView(data: [282.502, 284.495, 283.51, 285.019, 285.197, 286.118, 288.737, 288.455, 289.391, 287.691, 285.878, 286.46, 286.252, 284.652, 284.129, 284.188], title: String(stock.regularMarketPrice), legend: String(stock.regularMarketChange), style: Styles.lineChartStyleOne)
        }
    }
}

private let stocksExample: [Quotes] = [
    Quotes(
        symbol: "AAPL",
        longName: "Apple Inc.",
        regularMarketPrice: 131.93,
        regularMarketChange: 0.12,
        regularMarketChangePercent: 1.15
    ),
    
]
struct StocksDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        StocksDetailsView(stock: stocksExample[0])
    }
}
