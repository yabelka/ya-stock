//
//  ImageWithURL.swift
//  YA.STOCK
//
//  Created by Яна Белкина on 27.03.2021.
//

import SwiftUI

struct ImageWithURL: View {
    
    @ObservedObject var imageLoader: ImageLoaderAndCache

    init(_ url: String) {
        imageLoader = ImageLoaderAndCache(imageURL: url)
    }

    var body: some View {
        VStack{
            if (UIImage(data: self.imageLoader.imageData) != nil) {
                Image(uiImage: UIImage(data: self.imageLoader.imageData) ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    
            } else {
                VStack{
                    ActivityIndicator(style: .medium)
                }
            }
        }
    }
}

//struct ImageWithURL_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageWithURL()
//    }
//}
