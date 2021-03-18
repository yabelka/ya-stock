//
//  StocksDetailsView.swift
//  YA.STOCK
//
//  Created by Яна Белкина on 18.03.2021.
//

import SwiftUI

struct StocksDetailsView: View {
    var image: String
    var body: some View {
        Image(image)
    }
}

struct StocksDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        StocksDetailsView(image: "Fav")
    }
}
