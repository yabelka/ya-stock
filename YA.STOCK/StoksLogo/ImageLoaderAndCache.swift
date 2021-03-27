//
//  ImageLoaderAndCache.swift
//  YA.STOCK
//
//  Created by Яна Белкина on 27.03.2021.
//

import SwiftUI
//import Foundation

class ImageLoaderAndCache: ObservableObject {
    
    @Published var imageData = Data()
    
    init(imageURL: String) {
        let cache = URLCache.shared
        if (URL(string: imageURL) != nil) {
            let request = URLRequest(url: URL(string: imageURL)!, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 60.0)
            if let data = cache.cachedResponse(for: request)?.data {
                print("got image from cache")
                self.imageData = data
            } else {
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let data = data, let response = response {
                    let cachedData = CachedURLResponse(response: response, data: data)
                                        cache.storeCachedResponse(cachedData, for: request)
                        DispatchQueue.main.async {
                            print("downloaded from internet")
                            self.imageData = data
                        }
                    }
                }).resume()
            }
        }
    }
}

//struct ImageLoaderAndCache_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageLoaderAndCache()
//    }
//}
