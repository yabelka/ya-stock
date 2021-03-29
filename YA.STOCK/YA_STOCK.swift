//
//  YA_STOCKApp.swift
//  YA.STOCK
//
//  Created by Яна Белкина on 18.03.2021.
//

import SwiftUI

public var mboumApiKey = "ISzZfz9I8t1ktX6Z1Dc3cKmPY4Gdun3343gKIRHoKAqaeM0kfRdDMk85oMfd"

@main
struct YA_STOCKApp: App {
    var body: some Scene {
        WindowGroup {
            StocksListView()
        }
    }
}
