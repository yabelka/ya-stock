//
//  ContentView.swift
//  YA.STOCK
//
//  Created by Яна Белкина on 18.03.2021.
//

import SwiftUI

public struct Stock: Identifiable {
    let ticker: String
    var icon: String { ticker }
    let companyName: String
    let price: String
    let diff: String
    let isFavorite: Bool
    let index: Int
    public var id: String { ticker }
    
}

private let stocks: [Stock] = [
    Stock(ticker: "AAPL", companyName: "Apple Inc.", price: "$131.93", diff: "+$0.12 (1,15%)", isFavorite: true, index: 0),
    Stock(ticker: "MSFT", companyName: "Microsoft Corporation", price: "$3 204", diff: "+$0.12 (1,15%)", isFavorite: false, index: 1),
    
    Stock(ticker: "AAPL", companyName: "Apple Inc.", price: "$131.93", diff: "+$0.12 (1,15%)", isFavorite: true, index: 2),
    Stock(ticker: "MSFT", companyName: "Microsoft Corporation", price: "$3 204", diff: "+$0.12 (1,15%)", isFavorite: false, index: 3),
    
    Stock(ticker: "AAPL", companyName: "Apple Inc.", price: "$131.93", diff: "+$0.12 (1,15%)", isFavorite: true, index: 4),
    Stock(ticker: "MSFT", companyName: "Microsoft Corporation", price: "$3 204", diff: "+$0.12 (1,15%)", isFavorite: false, index: 5),

    
]


struct StocksListView: View {
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
               VStack {
                    ForEach(stocks) { stock in
                        NavigationLink(destination: StocksDetailsView(stock: stock)) {
                            StockCard(stock: stock)
                        }
                    }
                }
            }
        }
    }
}


struct StockCard: View {
    
    fileprivate var stock: Stock
    
    var body: some View {
        
        HStack(alignment: .center) {
            Image(stock.icon)
                .cornerRadius(8)
                .padding(.trailing, 12.0)
            VStack(alignment: .leading) {
                HStack {
                    Text(stock.ticker)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                    Image(stock.isFavorite ? "Fav" : "NotFav")
                }
                .padding(0)
                .frame(height: 24.0)
                Text(stock.companyName)
                    .font(.system(size: 11))
                    .fontWeight(.semibold)
            }
            .frame(height: 40.0)
            Spacer()
            VStack(alignment: .trailing) {
                Text(stock.price)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                Spacer()
                Text(stock.diff)
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(hue: 0.4, saturation: 0.753, brightness: 0.661))
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

struct StocksListView_Previews: PreviewProvider {
    static var previews: some View {
        StocksListView()
            .previewDevice("iPhone 11 Pro Max")
    }
}
