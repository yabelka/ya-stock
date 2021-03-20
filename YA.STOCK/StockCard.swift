//
//  StockCard.swift
//  YA.STOCK
//
//  Created by Яна Белкина on 20.03.2021.
//

import SwiftUI

struct StockCard: View {
    
    var stock: Quotes
    
    var body: some View {
        let ticker = stock.symbol
        let price = round(stock.regularMarketPrice * 100) / 100
        let priceChange = round(stock.regularMarketChange * 100) / 100
        let percentChange = round(stock.regularMarketChangePercent * 100) / 100
        
        let changePriceSymbol = priceChange == 0 ? "" : priceChange > 0 ? "+" : "-"
        let changePriceColor = priceChange == 0 ? Color.text_minor : priceChange > 0 ? Color.text_good : Color.text_bad
        let currencySymbol = "$"
        
        HStack(alignment: .center) {
//            Image(stock.icon)
//                .cornerRadius(8)
//                .padding(.trailing, 12.0)
            VStack(alignment: .leading) {
                HStack {
                    Text(ticker)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(Color.text_primary)
//                    Image(stock.isFavorite ? "Fav" : "NotFav")
                }
                .padding(0)
                .frame(height: 24.0)
                Text(stock.longName)
                    .font(.system(size: 11))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.text_primary)
            }
            .frame(height: 40.0)
            Spacer()
            VStack(alignment: .trailing) {
                Text(String(price))
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(Color.text_primary)
                Spacer()
                Text("\(changePriceSymbol)\(currencySymbol)\(String(abs(priceChange))) (\(String(abs(percentChange)))%)")
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
                    .foregroundColor(changePriceColor)
            }
            .padding(.trailing, 8.0)
            .frame(height: 40.0)
            
        }
        .padding(8)
        .background(Color(red: 0.94, green: 0.9568, blue: 0.9686, opacity: 1.0))
        .cornerRadius(16)
        .padding(.horizontal, 16)
    }

}

private let stocksExample: [Quotes] = [
    Quotes(
        symbol: "TICKER1",
        longName: "Company Name1",
        regularMarketPrice: 101.00,
        regularMarketChange: 0.00,
        regularMarketChangePercent: 0.00
    ),
    Quotes(
        symbol: "TICKER2",
        longName: "Company Name2",
        regularMarketPrice: 102.00,
        regularMarketChange: -0.12,
        regularMarketChangePercent: -1.15
    ),
    Quotes(
        symbol: "TICKER3",
        longName: "Company Name3",
        regularMarketPrice: 103.00,
        regularMarketChange: 0.12,
        regularMarketChangePercent: 1.15
    ),
    
]

struct StockCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StockCard(stock: stocksExample[0])
            StockCard(stock: stocksExample[1])
            StockCard(stock: stocksExample[2])
        }
        .previewLayout(.sizeThatFits)
        
    }
}
