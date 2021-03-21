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
            LineView(data: TestData.values,
                     title: String(stock.regularMarketPrice),
                     legend: String(stock.regularMarketChange),
                     style: Styles.lineChartStyleOne)
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
