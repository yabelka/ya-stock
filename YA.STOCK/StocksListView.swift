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
    @State private var searchText : String = ""

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(stocks.filter { self.searchText.isEmpty ? true : $0.symbol.lowercased().contains(self.searchText.lowercased()) ||
                            $0.longName.lowercased().contains(self.searchText.lowercased())
                        }, id: \.id) { stock in
                            NavigationLink(destination: StocksDetailsView(stock: stock)) {
                                StockCard(stock: stock)
                            }
                        }
                    }
                }.navigationBarTitle(Text("Stocks"))
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
                    print("=======", data)
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

struct StocksListView_Previews: PreviewProvider {
    static var previews: some View {
        StocksListView()
            .previewDevice("iPhone 11 Pro Max")
    }
}
