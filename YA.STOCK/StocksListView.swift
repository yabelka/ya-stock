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
    @State var favStocks = [Quotes]()
    @State private var searchText : String = ""
    
    @State var screenMode:String = "all" // all, fav
    
    @ObservedObject var globalStocksData = GlobalStocksData()

    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                SearchBar(text: $searchText)
                
                if (!self.searchText.isEmpty) {
                    HStack{
                        Spacer()
                        Button(action: {
                            globalStocksData.res = stocksSearchResult
                        }){
                            Text("Search")
                                .foregroundColor(Colors.invert)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Colors.primary)
                                .cornerRadius(8)
                        }
                        .padding(.trailing, 8)
                    }
                }
                
                HStack(alignment: .bottom){
                    Button(action: {
                        loadTopStocksData()
                        self.screenMode = "all"
                    }){
                        Text("Stocks")
                            .font(self.screenMode == "all" ? .title : .title2)
                            .fontWeight(.bold)
                            .foregroundColor( self.screenMode == "all" ? Colors.primary : Colors.minor)
                            .padding(.bottom, self.screenMode == "all" ? 0 : 2)
                    }
                    Button(action: {
                        loadFavStocksData()
                        self.screenMode = "fav"
                    }){
                        Text("Favorite")
                            .font(self.screenMode == "fav" ? .title : .title2)
                            .fontWeight(.bold)
                            .foregroundColor(self.screenMode == "fav" ? Colors.primary : Colors.minor)
                            .padding(.bottom, self.screenMode == "fav" ? 0 : 2)
                    }
                }.padding(.horizontal, 8)
               
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(self.screenMode == "all" ? globalStocksData.res : self.favStocks, id: \.id) { stock in
                            NavigationLink(destination: StocksDetailsView(stock: stock)) {
                                StockCard(stock: stock)
                            }
                        }
                    }
                }.navigationBarHidden(true)
            }
        }
        .onAppear(){
            loadTopStocksData()
            
        }
    }
    
    
    func loadTopStocksData() {
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
            favArray =  UserDefaults.standard.stringArray(forKey: "FavoriteStocks")          
        }
        
        UserDefaults.standard.set("all", forKey: "ScreenMode")
        
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
    
    func loadFavStocksData() {
        let headers = [
            "X-Mboum-Secret": mboumApiKey
//            "X-Mboum-Secret": "demo"
        ]
        
        let favStocksArray: [String] = favArray!
        let favStocksString = favStocksArray.joined(separator: ",")
        print(favStocksString as Any)
        if ((favArray?.count) != nil) {
            let request = NSMutableURLRequest(
                url: NSURL(string: "https://mboum.com/api/v1/qu/quote/?symbol=\(favStocksString)")! as URL,
//                url: NSURL(string: "https://mboum.com/api/v1/qu/quote/?symbol=AAPL,F")! as URL,
                cachePolicy: .useProtocolCachePolicy,
                timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                if (error != nil) {
                    print(error!)
                } else {
                    if let data = data {
                        if let decodedResponse = try? JSONDecoder().decode([Quotes].self, from: data) {
                                DispatchQueue.main.async {
                                    self.favStocks = decodedResponse
                                    print(decodedResponse)
                                }
                                return
                            }
                            print("loadSearchStockInfo - Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                    }
                }
            }.resume()
        } else {
            print("No fav stocks to load")
        }

       
    }
}

struct StocksListView_Previews: PreviewProvider {
    static var previews: some View {
        StocksListView()
            .previewDevice("iPhone 11 Pro Max")
    }
}
