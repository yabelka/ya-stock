//
//  SearchBar.swift
//  YA.STOCK
//
//  Created by Яна Белкина on 20.03.2021.
//

import SwiftUI

public struct SearchResponse: Decodable {
    var result: [SearchResult]
}

public struct SearchResult: Decodable {
    var symbol: String
}


func loadSearchData (searchText: String) {
    let headers = [
        "X-Finnhub-Token" : "c1djiu748v6tbf1bmiv0",
    ]

    let request = NSMutableURLRequest(
        url: NSURL(string: "https://finnhub.io/api/v1/search?q=\(searchText)")! as URL,
        cachePolicy: .useProtocolCachePolicy,
        timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    if searchText.isEmpty {
        print("No text in serch bar")
        return
    }
    
    URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
        if (error != nil) {
            print(error!)
        } else {
            if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(SearchResponse.self, from: data) {
                        DispatchQueue.main.async {
                            let res = decodedResponse.result
                            var stocks: [String] = []
                            for r in res {
                                stocks.append(r.symbol)
                            }
                            stoksSearchResultStrings = stocks.joined(separator: ",")
                            loadSearchStockInfo()
                        }
                        return
                    }
                    print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }.resume()
}



func loadSearchStockInfo () {
    let headers = [
//        "X-Mboum-Secret": "7eX01cwMAgGLRfewRyo9fJeCgO7edyzovUVSZlmMTLJCmLQfRALu5qILrQMz"
        "X-Mboum-Secret": "demo"
    ]

    let request = NSMutableURLRequest(
//        url: NSURL(string: "https://mboum.com/api/v1/qu/quote/?symbol=\(stoksSearchResultStrings)")! as URL,
        url: NSURL(string: "https://mboum.com/api/v1/qu/quote/?symbol=AAPL,F")! as URL,
        cachePolicy: .useProtocolCachePolicy,
        timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    if stoksSearchResultStrings.isEmpty {
        print("No res from search bar")
        return
    }
    
    URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
        if (error != nil) {
            print(error!)
        } else {
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([Quotes].self, from: data) {
                        DispatchQueue.main.async {
                            stocksSearchResult=decodedResponse
                            print(decodedResponse)
                        }
                        return
                    }
                    print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }.resume()
}

public var stoksSearchResultStrings:String = ""


struct SearchBar: UIViewRepresentable {

    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            loadSearchData(searchText: text)
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Company name or Stock Symbol"
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}
