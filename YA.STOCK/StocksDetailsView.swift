//
//  StocksDetailsView.swift
//  YA.STOCK
//
//  Created by Яна Белкина on 18.03.2021.
//

import SwiftUI

struct StockDetailResponse: Decodable {
    var items: Items
}

struct Items: Decodable {
    var array: [StockDetailForTime]
    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

        var tempArray = [StockDetailForTime]()
        for key in container.allKeys {
            let decodedObject = try container.decode(StockDetailForTime.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            tempArray.append(decodedObject)
        }
        array = tempArray
    }
}

struct StockDetailForTime: Decodable {
    let date: String
//    var open: Double
//    var high: Double
//    var low: Double
    var close: Double
    var id: String { date }
    let realDate: String
    enum CodingKeys: CodingKey {
        case date
        case close
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(String.self, forKey: CodingKeys.date)
        close = try container.decode(Double.self, forKey: CodingKeys.close)
        realDate = container.codingPath[1].stringValue
    }
}

struct StocksDetailsView: View {
    var stock: Quotes
    @State var detailInfo = [StockDetailForTime]()
    @State var chartValues: Any?
    @State var selectedDataPeriod: String = "3mo"
    
    let buttons: Array = ["1d", "1wk", "1mo", "3mo"]
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var btnBack : some View {
        Button(action: { self.presentationMode.wrappedValue.dismiss()}) {
            Image(systemName: "arrow.backward")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Colors.primary)
        }
    }

    var body: some View {
        VStack{            
            ZStack(alignment: .top){
                VStack{
                    StockPrice(price: Double(stock.regularMarketPrice))
                    StockChanges(priceChange: Double(stock.regularMarketChange), percentChande: Double(stock.regularMarketChangePercent))
                }
                VStack{
                    if chartValues != nil {
                        LineView(data: ChartData(values: chartValues as! [(String, Int)]),
                         title: String(stock.regularMarketPrice),
                         legend: String(stock.regularMarketChange),
                         style: Styles.lineChartStyleOne)
                        } else {
                            Text("No stock data")
                        }
                }
                .frame(height: 240 + 60)
            }
            HStack{
                ForEach(buttons, id: \.self) { b in
                    Button(action: {
                        self.selectedDataPeriod = b
                        loadData()
                    }) {
                        VStack{
                            Text(b)
                                .foregroundColor(Colors.invert)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .frame(minWidth: 60)
                        .background(Colors.primary)
                        .cornerRadius(8)
                    }.onAppear(perform: loadData)
                }
            }
            .padding(.bottom, 18.0)
            .padding(.top, 36)
            Spacer()
        }
        .onAppear(perform: loadData)
        .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    btnBack
                }
                ToolbarItem(placement: .principal) {
                    VStack{
                        StockSymbol(symbol: stock.symbol)
                        StockComanyName(comanyName: stock.longName)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    FavStar(stock: stock.symbol)
                }
            }
                        
    }
    
    
    func getValuesForChart() {
        var values: [Any] = []
        print("debug Data detailInfo", detailInfo, detailInfo.count)

        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MM-yyyy"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM, yyyy"

        let sortedDetailInfo = detailInfo.sorted(by: {$1.realDate.compare($0.realDate) == .orderedDescending})
        
        let firstFifty = sortedDetailInfo
            .suffix(50)
        for d in firstFifty {
            
            var formatedDate = d.date
            if let dateFopmated = dateFormatterGet.date(from: d.date) {
                formatedDate = dateFormatterPrint.string(from: dateFopmated)
            } else {
                print("There was an error decoding the string")
            }
            values.append((String(formatedDate), Int(d.close)))
        }
        self.chartValues = values
    }
    
    func loadData() {
        let headers = [
//            "X-Mboum-Secret": "demo"
            "X-Mboum-Secret": mboumApiKey
        ]

        let request = NSMutableURLRequest(
//            url: NSURL(string: "https://mboum.com/api/v1/hi/history/?symbol=F&interval=\(self.selectedDataPeriod)&diffandsplits=true")! as URL,
            url: NSURL(string: "https://mboum.com/api/v1/hi/history/?symbol=\(stock.symbol)&interval=\(self.selectedDataPeriod)&diffandsplits=true")! as URL,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            if (error != nil) {
                print(error!)
            } else {
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(StockDetailResponse.self, from: data) {
                        DispatchQueue.main.async {
                            self.detailInfo = decodedResponse.items.array
                        }
                        getValuesForChart()
                        return
                    }
                    print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }.resume()
        
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
