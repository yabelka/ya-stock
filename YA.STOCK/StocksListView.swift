//
//  ContentView.swift
//  YA.STOCK
//
//  Created by Яна Белкина on 18.03.2021.
//

import SwiftUI

public struct Response: Decodable {
    var quotes: [Quotes]
}

public struct Quotes: Decodable {
    var symbol: String
    var longName: String
    var regularMarketPrice: Float
    var regularMarketChange: Float
    var regularMarketChangePercent: Float
    var id: String { symbol }
}

public var stocksSearchResult = [Quotes]()

class GlobalStocksData: ObservableObject {
  @Published var res = [Quotes]()
}

struct StocksListView: View {
    @State var stocks = [Quotes]()
    @State private var searchText : String = ""
    
    @ObservedObject var globalStocksData = GlobalStocksData()

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                HStack{
                    Button(action: {
                        loadData()
                    }){
                        Text("Stocks")
                    }
                    Button(action: {
                        let res = globalStocksData.res.filter { favArray!.contains($0.symbol) }
                        globalStocksData.res = res
                    }){
                        Text("Favorite")
                    }
                }
                if (!self.searchText.isEmpty) {
                    Button(action: {
                        globalStocksData.res = stocksSearchResult
                    }){
                        Text("Search")
                    }
                }
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(globalStocksData.res
//                                    .filter { self.searchText.isEmpty ? true : $0.symbol.lowercased().contains(self.searchText.lowercased()) ||
//                            $0.longName.lowercased().contains(self.searchText.lowercased())
//                        }
                                ,id: \.id) { stock in
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
        
        if favArray == nil {
            UserDefaults.standard.set([], forKey: "FavoriteStocks")
        }
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if (error != nil) {
                print(error!)
            } else {
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                        DispatchQueue.main.async {
                            globalStocksData.res = decodedResponse.quotes
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
