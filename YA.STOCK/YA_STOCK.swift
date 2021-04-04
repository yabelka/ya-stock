//
//  YA_STOCKApp.swift
//  YA.STOCK
//
//  Created by Яна Белкина on 18.03.2021.
//

import SwiftUI

public var mboumApiKey = "HI2dfdls3OaPEwEDAotoesPHOVbYn2POIqiyCNNUAHvrIy0EcsbOjyIchFkz"

@main
struct YA_STOCKApp: App {
    var body: some Scene {
        WindowGroup {
            StocksListView()
        }
    }
}
