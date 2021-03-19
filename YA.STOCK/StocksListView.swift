//
//  ContentView.swift
//  YA.STOCK
//
//  Created by Яна Белкина on 18.03.2021.
//

import SwiftUI

struct Response: Decodable {
    var quotes: [Quotes]
}

struct Quotes: Decodable {
    var symbol: String
    var longName: String
    var regularMarketPrice: Float
    var regularMarketChange: Float
    var regularMarketChangePercent: Float
    var id: String { symbol }
}

struct StocksListView: View {
    @State var stocks = [Quotes]()
    
//    var body: some View {
//        List(stocks, id: \.id) { item in
//            VStack{
////                Text(item.symbol)
//                StockCard(stock: item)
//            }
//        }
//        .onAppear(perform: loadData)
//    }
//
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(stocks, id: \.id) { stock in
                        NavigationLink(destination: StocksDetailsView(stock: stock)) {
                            StockCard(stock: stock)
                        }
                    }
                }
            }
        }
        .onAppear(perform: loadData)
    }
    
    
    func loadData() {
        let headers = [
            "X-Mboum-Secret": "demo"
        ]

        let request = NSMutableURLRequest(
            url: NSURL(string: "https://mboum.com/api/v1/co/collections/?list=undervalued_growth_stocks")! as URL,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if (error != nil) {
                print(error!)
            } else {
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                        DispatchQueue.main.async {
                            self.stocks = decodedResponse.quotes
                        }
                        return
                    }
                    print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }.resume()
    }
}


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


struct StockCard: View {
    
    fileprivate var stock: Quotes
    
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

struct StocksListView_Previews: PreviewProvider {
    static var previews: some View {
        StocksListView()
            .previewDevice("iPhone 11 Pro Max")
    }
}
