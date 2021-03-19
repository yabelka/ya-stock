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
    var shortName: String
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
//                        NavigationLink(destination: StocksDetailsView(stock: stock)) {
                            StockCard(stock: stock)
//                        }
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
            url: NSURL(string: "https://mboum.com/api/v1/co/collections/?list=day_gainers")! as URL,
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

//private let stocks: [Stock] = [
//    Stock(ticker: "AAPL", companyName: "Apple Inc.", price: "$131.93", diff: "+$0.12 (1,15%)", isFavorite: true, index: 0),
//    Stock(ticker: "MSFT", companyName: "Microsoft Corporation", price: "$3 204", diff: "+$0.12 (1,15%)", isFavorite: false, index: 1),
//
//    Stock(ticker: "AAPL", companyName: "Apple Inc.", price: "$131.93", diff: "+$0.12 (1,15%)", isFavorite: true, index: 2),
//    Stock(ticker: "MSFT", companyName: "Microsoft Corporation", price: "$3 204", diff: "+$0.12 (1,15%)", isFavorite: false, index: 3),
//
//    Stock(ticker: "AAPL", companyName: "Apple Inc.", price: "$131.93", diff: "+$0.12 (1,15%)", isFavorite: true, index: 4),
//    Stock(ticker: "MSFT", companyName: "Microsoft Corporation", price: "$3 204", diff: "+$0.12 (1,15%)", isFavorite: false, index: 5),
//
//
//]


struct StockCard: View {
    
    fileprivate var stock: Quotes
    
    var body: some View {
        
        HStack(alignment: .center) {
//            Image(stock.icon)
//                .cornerRadius(8)
//                .padding(.trailing, 12.0)
            VStack(alignment: .leading) {
                HStack {
                    Text(stock.symbol)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
//                    Image(stock.isFavorite ? "Fav" : "NotFav")
                }
                .padding(0)
                .frame(height: 24.0)
                Text(stock.longName)
                    .font(.system(size: 11))
                    .fontWeight(.semibold)
            }
            .frame(height: 40.0)
            Spacer()
            VStack(alignment: .trailing) {
                Text(String(stock.regularMarketPrice))
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                Spacer()
                Text(String(stock.regularMarketChangePercent))
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
