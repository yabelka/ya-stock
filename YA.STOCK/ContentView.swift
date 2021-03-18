//
//  ContentView.swift
//  YA.STOCK
//
//  Created by Яна Белкина on 18.03.2021.
//

import SwiftUI

var str = "str"

var array = [1, 2, 3, 4]

//var array2 = [
//    {arrId: 1, }
//]
private struct NamedFont: Identifiable {
    let name: String
    let font: Font
    var id: String { name }
}

private let namedFonts: [NamedFont] = [
    NamedFont(name: "Large Title", font: .largeTitle),
    NamedFont(name: "Title", font: .title),
    NamedFont(name: "Headline", font: .headline),
    NamedFont(name: "Body", font: .body),
    NamedFont(name: "Caption", font: .caption)
]

private struct Stock: Identifiable {
    let ticker: String
    var icon: String { ticker }
    let companyName: String
    let price: String
    let diff: String
    let isFavorite: Bool
    var id: String { ticker }
}

private let stocks: [Stock] = [
    Stock(ticker: "AAPL", companyName: "Apple Inc.", price: "$131.93", diff: "+$0.12 (1,15%)", isFavorite: true),
    Stock(ticker: "MSFT", companyName: "Microsoft Corporation", price: "$3 204", diff: "+$0.12 (1,15%)", isFavorite: false),
    
    Stock(ticker: "AAPL", companyName: "Apple Inc.", price: "$131.93", diff: "+$0.12 (1,15%)", isFavorite: true),
    Stock(ticker: "MSFT", companyName: "Microsoft Corporation", price: "$3 204", diff: "+$0.12 (1,15%)", isFavorite: false),
    
    Stock(ticker: "AAPL", companyName: "Apple Inc.", price: "$131.93", diff: "+$0.12 (1,15%)", isFavorite: true),
    Stock(ticker: "MSFT", companyName: "Microsoft Corporation", price: "$3 204", diff: "+$0.12 (1,15%)", isFavorite: false),

    
]


struct ContentView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
        VStack {
            ForEach(stocks) { stock in
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
        }
    }
}

//struct ContentView: View {
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("Hello World")
//            Text("Another")
////            Spacer()
//        }.frame(minWidth: 0,
//                maxWidth: .infinity
////                minHeight: 0,
////                maxHeight: .infinity,
////                alignment: .topLeading
//        ).background(Color.red)
//    }
//}


struct StockCardView: View {
    
//    @ObservedObject var expenseObj: ExpenseCD
//    @AppStorage(UD_EXPENSE_CURRENCY) var CURRENCY: String = ""
    
    var body: some View {
        
        
//        NavigationLink(destination: NavigationLazyView(ExpenseFilterView(categTag: expenseObj.tag)), label: {
//            Image(getTransTagIcon(transTag: expenseObj.tag ?? ""))
//                .resizable().frame(width: 24, height: 24).padding(16)
//                .background(Color.primary_color).cornerRadius(4)
//        })
        
        HStack(alignment: .center) {
            Image("AAPL")
                .cornerRadius(8)
                .padding(.trailing, 12.0)
            VStack(alignment: .leading) {
                HStack {
                    Text("AAPL")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                    Image("NotFav")
                }
                .padding(0)
                .frame(height: 24.0)
                Text("Apple Inc.")
                    .font(.system(size: 11))
                    .fontWeight(.semibold)
            }
            .frame(height: 40.0)
            Spacer()
            VStack(alignment: .trailing) {
                Text("$131.93")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                Spacer()
                Text("+$0.12 (1,15%)")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11 Pro Max")
    }
}
