//
//  YA_STOCKApp.swift
//  YA.STOCK
//
//  Created by Яна Белкина on 18.03.2021.
//

import SwiftUI
import Foundation


@main
struct YA_STOCKApp: App {
    init(){
        let headers = [
            "X-Mboum-Secret": "demo"
        ]

        let request = NSMutableURLRequest(
            url: NSURL(string: "https://mboum.com/api/v1/co/collections/?list=day_gainers&start=1")! as URL,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse!)
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("Response data string:\n \(dataString)")
                }
            }
        })
        
        dataTask.resume()
    }
    
//    init(){
//        let headers = [
//            "X-Finnhub-Token": "c1ae1bn48v6ulhh7kbrg"
//        ]
//
//        let request = NSMutableURLRequest(
//            url: NSURL(string: "https://finnhub.io/api/v1/stock?token=")! as URL,
//            cachePolicy: .useProtocolCachePolicy,
//            timeoutInterval: 10.0)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if (error != nil) {
//                print(error!)
//            } else {
//                let httpResponse = response as? HTTPURLResponse
//                print(httpResponse!)
//                if let data = data, let dataString = String(data: data, encoding: .utf8) {
//                    print("Response data string:\n \(dataString)")
//                }
//            }
//        })
//
//        dataTask.resume()
//    }

    var body: some Scene {
        WindowGroup {
            StocksListView()
        }
    }
}
