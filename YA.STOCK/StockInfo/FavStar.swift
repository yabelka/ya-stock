//
//  FavStar.swift
//  YA.STOCK
//
//  Created by Яна Белкина on 29.03.2021.
//

import SwiftUI


class GlobalFav: ObservableObject {
  @Published var updateStarStatus = false
}

public var favArray = UserDefaults.standard.stringArray(forKey: "FavoriteStocks")

struct FavStar: View {
    @ObservedObject var globalFav = GlobalFav()
    var stock: String
    var body: some View {
        let defaults = UserDefaults.standard
        HStack{
            Button(action: {
                if favArray != nil && favArray!.contains(stock) {
                    globalFav.updateStarStatus = false
                    let index = favArray!.firstIndex(of: stock)
                    favArray!.remove(at: index!)
                    defaults.set(favArray, forKey: "FavoriteStocks")
                } else {
                    globalFav.updateStarStatus = true
                    favArray?.append(stock)
                    defaults.set(favArray, forKey: "FavoriteStocks")
                }
            }){
                Image((favArray != nil && favArray!.contains(stock)) ? "Fav" : "NotFav")
            }
        }
    }
}

struct FavStar_Previews: PreviewProvider {
    static var previews: some View {
        FavStar(stock: "AAPL")
    }
}
